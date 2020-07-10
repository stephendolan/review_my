class Snippets::Delete < BrowserAction
  route do
    snippet = SnippetQuery.find(snippet_id)

    unless snippet.delete
      flash.failure = "Unable to delete record."
      flash.keep
    end

    redirect to: Snippets::Index
  end
end
