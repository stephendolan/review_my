class Snippets::Delete < BrowserAction
  delete "/snippets/:snippet_id" do
    snippet = SnippetQuery.new
      .creator_id(current_user.id)
      .find(snippet_id)

    unless snippet.delete
      flash.failure = "Unable to delete record."
    end

    redirect to: Dashboard::Index
  end
end
