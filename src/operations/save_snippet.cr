class SaveSnippet < Snippet::SaveOperation
  needs current_user : User

  permit_columns title, content

  before_save do
    assign_creator
    assign_slug
    parse_content
    validate_uniqueness_of slug
  end

  private def parse_content
    content.value = JSON.parse(content.value.to_s)
  end

  private def assign_creator
    creator_id.value = current_user.id
  end

  private def assign_slug
    return unless slug.value.nil?

    slug_value = random_slug
    iterations = 0

    while SnippetQuery.new.slug(slug_value).any? && iterations < 5
      slug_value = random_slug
      iterations += 1
    end

    slug.value = slug_value
  end

  private def random_slug
    Random::Secure.hex(6)
  end
end
