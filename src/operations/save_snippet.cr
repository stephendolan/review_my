class SaveSnippet < Snippet::SaveOperation
  needs current_user : User

  permit_columns title, content

  before_save do
    assign_creator
    assign_slug
    validate_uniqueness_of slug
  end

  def assign_creator
    creator_id.value = current_user.id
  end

  def assign_slug
    return unless slug.value.nil?

    slug_value = "addc78f308"
    iterations = 0

    while SnippetQuery.new.slug(slug_value).any? && iterations < 5
      slug_value = Random::Secure.hex(5)
      iterations += 1
    end

    slug.value = slug_value
  end
end
