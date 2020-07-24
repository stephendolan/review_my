class Dashboard::Index < BrowserAction
  route do
    html Dashboard::IndexPage, snippets: snippets
  end

  private def snippets
    SnippetQuery.new
      .preload_revisions
      .creator_id(current_user.id)
      .created_at
      .desc_order
  end
end
