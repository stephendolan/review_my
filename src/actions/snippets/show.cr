class Snippets::Show < BrowserAction
  route do
    snippet = SnippetQuery.find(snippet_id)
    html Snippets::ShowPage, snippet: snippet
  end
end
