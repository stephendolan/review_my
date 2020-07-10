class Snippets::Revisions::New < BrowserAction
  include Auth::AllowGuests

  nested_route do
    snippet = SnippetQuery.find(snippet_id)
    user = current_user
    flash.keep

    if snippet.domain_restricted? && (user.nil? || snippet.creator.email_domain != user.email_domain)
      flash.failure = "That snippet is private! Sign in to add a revision!"
      redirect to: Home::Index
    end

    if snippet.creator == user
      redirect to: Snippets::Show.with(snippet.slug)
    elsif user && (revision = snippet.revisions.find { |revision| revision.creator == user })
      redirect to: Snippets::Revisions::Show.with(snippet_id: snippet.slug, revision_id: revision.id)
    else
      html Snippets::Revisions::NewPage,
        snippet: snippet,
        save_revision: SaveRevision.new(current_user: user, snippet: snippet)
    end
  end
end
