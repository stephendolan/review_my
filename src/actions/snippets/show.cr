class Snippets::Show < BrowserAction
  route do
    snippet = SnippetQuery.new.creator_id(current_user.id).find(snippet_id)

    html Snippets::ShowPage, snippet: snippet
  end
end
