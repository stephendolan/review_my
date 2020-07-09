class Snippets::Index < BrowserAction
  route do
    html Snippets::IndexPage, snippets: snippets
  end

  private def snippets
    SnippetQuery.new
      .preload_revisions
      .creator_id(current_user.id)
      .created_at
      .desc_order
  end
end
