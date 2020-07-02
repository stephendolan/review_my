class Snippets::Revisions::Show < BrowserAction
  nested_route do
    revision = RevisionQuery.new.preload_snippet(SnippetQuery.new.preload_creator).preload_creator.find(revision_id)

    if revision_creator?(revision) || snippet_creator?(revision.snippet)
      html Snippets::Revisions::ShowPage, revision: revision
    else
      redirect to: Home::Index
    end
  end

  private def revision_creator?(revision)
    revision.creator == current_user
  end

  private def snippet_creator?(snippet)
    snippet.creator == current_user
  end
end
