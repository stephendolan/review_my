class Snippets::New < BrowserAction
  route do
    html Snippets::NewPage, save_snippet: SaveSnippet.new(current_user: current_user)
  end
end
