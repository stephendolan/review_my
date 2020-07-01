class Snippets::Revisions::New < BrowserAction
  include Auth::AllowGuests

  nested_route do
    snippet = SnippetQuery.find(snippet_id)
    html Snippets::Revisions::NewPage,
      snippet: snippet,
      save_revision: SaveRevision.new(current_user: current_user, snippet: snippet)
  end
end
