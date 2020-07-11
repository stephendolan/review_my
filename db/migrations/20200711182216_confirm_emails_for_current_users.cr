class ConfirmEmailsForCurrentUsers::V20200711182216 < Avram::Migrator::Migration::V1
  def migrate
    UserQuery.new.each do |user|
      ConfirmSignUp.create!(user, confirmed_at: Time.utc)
    end
  end

  def rollback
    UserQuery.new.each do |user|
      ConfirmSignUp.create!(user, confirmed_at: nil)
    end
  end
end
