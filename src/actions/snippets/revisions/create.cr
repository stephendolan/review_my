class Snippets::Revisions::Create < BrowserAction
  include Auth::AllowGuests

  nested_route do
    snippet = SnippetQuery.find(snippet_id)

    if snippet.creator == current_user
      redirect to: Snippets::Show.with(snippet.slug)
    elsif current_user && (revision = snippet.revisions.find { |revision| revision.creator == current_user })
      redirect to: Snippets::Revisions::Show.with(snippet_id: snippet.slug, revision_id: revision.id)
    else
      SaveRevision.create(params, current_user: current_user, snippet: snippet) do |operation, revision|
        if revision
          if snippet.creator == current_user
            redirect to: Snippets::Show.with(snippet.slug)
          elsif current_user && revision.creator == current_user
            redirect to: Snippets::Revisions::Show.with(snippet_id: snippet.slug, revision_id: revision.id)
          else
            redirect to: Home::Index
          end
        else
          html Snippets::Revisions::NewPage, snippet: snippet, save_revision: operation
        end
      end
    end
  end
end
