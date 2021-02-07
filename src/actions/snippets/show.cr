class Snippets::Show < BrowserAction
  get "/snippets/:snippet_id" do
    snippet = SnippetQuery.new.creator_id(current_user.id).find(snippet_id)

    html Snippets::ShowPage, snippet: snippet
  end
end
