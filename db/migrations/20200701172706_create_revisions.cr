class CreateRevisions::V20200701172706 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Revision) do
      primary_key id : UUID
      add content : String
      add creator_name : String?
      add_belongs_to creator : User?, on_delete: :cascade, foreign_key_type: UUID
      add_belongs_to snippet : Snippet, on_delete: :cascade, foreign_key_type: UUID
      add_timestamps
    end

    create_index :revisions, [:creator_id, :snippet_id], unique: true
  end

  def rollback
    drop_index :revisions, [:creator_name, :snippet_id]
    drop table_for(Revision)
  end
end
