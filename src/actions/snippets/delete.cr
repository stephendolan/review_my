class Snippets::Delete < BrowserAction
  route do
    snippet = SnippetQuery.new
      .creator_id(current_user.id)
      .find(snippet_id)

    unless snippet.delete
      flash.failure = "Unable to delete record."
      flash.keep
    end

    redirect to: Dashboard::Index
  end
end
