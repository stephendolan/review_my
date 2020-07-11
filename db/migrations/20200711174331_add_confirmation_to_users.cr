class AddConfirmationToUsers::V20200711174331 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add confirmed_at : Time?
      add confirmation_token : String, fill_existing_with: "PRE_TOKEN_AUTH"
    end
  end

  def rollback
    alter table_for(User) do
      remove :confirmed_at
      remove :confirmation_token
    end
  end
end
