class Snippets::Revisions::Create < BrowserAction
  include Auth::AllowGuests

  post "/snippets/:snippet_id/revisions" do
    snippet = SnippetQuery.find(snippet_id)
    user = current_user

    if snippet.domain_restricted? && (user.nil? || snippet.creator.email_domain != user.email_domain)
      flash.failure = "That snippet is private. Sign in to add a revision!"
      redirect to: Home::Index
    end

    if snippet.creator == user
      redirect to: Snippets::Show.with(snippet.slug)
    elsif user && (revision = snippet.revisions.find { |rev| rev.creator == user })
      redirect to: Snippets::Revisions::Show.with(snippet_id: snippet.slug, revision_id: revision.id)
    else
      SaveRevision.create(params, current_user: user, snippet: snippet) do |operation, created_revision|
        if created_revision
          flash.success = "Your revision was created!"

          if snippet.creator == user
            redirect to: Snippets::Show.with(snippet.slug)
          elsif user && created_revision.creator_id == user.id
            redirect to: Snippets::Revisions::Show.with(snippet_id: snippet.slug, revision_id: created_revision.id)
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
