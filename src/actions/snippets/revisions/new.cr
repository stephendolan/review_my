class Snippets::Revisions::New < BrowserAction
  nested_route do
    snippet = SnippetQuery.find(snippet_id)
    html Snippets::Revisions::NewPage, snippet: snippet
  end
end
