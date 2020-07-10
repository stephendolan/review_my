class AddDomainRestrictedToSnippets::V20200710181005 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Snippet) do
      add domain_restricted : Bool, default: false
    end
  end

  def rollback
    alter table_for(Snippet) do
      remove :domain_restricted
    end
  end
end
