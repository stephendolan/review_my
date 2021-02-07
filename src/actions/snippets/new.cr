class Snippets::New < BrowserAction
  get "/snippets/new" do
    html Snippets::NewPage, save_snippet: SaveSnippet.new(current_user: current_user)
  end
end
