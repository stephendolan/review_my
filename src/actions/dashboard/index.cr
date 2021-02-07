class Dashboard::Index < BrowserAction
  RECENT_ACTIVITY_LIMIT = 10

  get "/dashboard" do
    html Dashboard::IndexPage, snippets: snippets, activities: recent_activity, snippet_count: SnippetQuery.new.creator_id(current_user.id).select_count
  end

  private def recent_activity
    (revisions_by_other_users.to_a + revisions_by_current_user.to_a)
      .sort_by(&.created_at)
      .reverse
      .first(RECENT_ACTIVITY_LIMIT)
  end

  private def revisions_by_current_user
    base_revision_query.creator_id(current_user.id)
  end

  private def revisions_by_other_users
    base_revision_query.where_snippet(SnippetQuery.new.creator_id(current_user.id))
  end

  private def base_revision_query
    RevisionQuery.new
      .preload_snippet
      .preload_creator
  end

  private def snippets
    SnippetQuery.new
      .preload_revisions
      .creator_id(current_user.id)
      .created_at
      .desc_order
  end
end
