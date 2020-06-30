class CreateSnippets::V20200627211018 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Snippet) do
      primary_key id : UUID
      add slug : String, index: true, unique: true
      add title : String
      add content : String
      add_belongs_to creator : User, on_delete: :cascade, foreign_key_type: UUID
      add_timestamps
    end
  end

  def rollback
    drop table_for(Snippet)
  end
end
