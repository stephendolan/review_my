class SnippetQuery < Snippet::BaseQuery
  def find(slug_or_id : String | UUID) : Snippet
    if slug_or_id.is_a?(UUID)
      previous_def(slug_or_id)
    else
      slug(slug_or_id).preload_creator.preload_revisions(RevisionQuery.new.preload_creator).first
    end
  end
end
