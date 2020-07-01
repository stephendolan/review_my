class SaveRevision < Revision::SaveOperation
  needs current_user : User?
  needs snippet : Snippet

  permit_columns creator_name, content

  before_save do
    assign_creator
    assign_snippet
    validate_content_not_identical
    validate_creator_or_name_is_present
    validate_uniqueness_of creator_id, query: RevisionQuery.new.snippet_id(snippet.id).creator_id
  end

  private def assign_creator
    return unless (user = current_user)
    creator_id.value = user.id
  end

  private def assign_snippet
    snippet_id.value = snippet.id
  end

  private def validate_content_not_identical
    content.value.try do |value|
      if value == snippet.content
        content.add_error "must be different from original snippet content"
      end
    end
  end

  private def validate_creator_or_name_is_present
    if current_user.nil?
      unless creator_name.value
        creator_name.add_error "is required"
      end
    end
  end
end
