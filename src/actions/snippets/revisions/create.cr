class Snippets::Revisions::Create < BrowserAction
  include Auth::AllowGuests

  nested_route do
    snippet = SnippetQuery.find(snippet_id)
    SaveRevision.create(params, current_user: current_user, snippet: snippet) do |operation, revision|
      if revision
        redirect to: Snippets::Show.with(snippet.slug)
      else
        html Snippets::Revisions::NewPage, snippet: snippet, save_revision: operation
      end
    end
  end
end
