class Snippets::Show < BrowserAction
  include Auth::AllowGuests

  route do
    snippet = SnippetQuery.find(snippet_id)
    html Snippets::ShowPage, snippet: snippet
  end
end
