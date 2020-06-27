class Snippets::Index < BrowserAction
  route do
    html Snippets::IndexPage, snippets: SnippetQuery.new.creator_id(current_user.id)
  end
end
