require "digest/md5"

class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column encrypted_password : String
    column confirmed_at : Time?
    column confirmation_token : String

    has_many snippets : Snippet
    has_many revisions : Revision
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def email_domain
    email.split("@").last
  end

  def gravatar_url(size = 200)
    gravatar_base_url = "https://gravatar.com/avatar/"
    hash = Digest::MD5.hexdigest(email.downcase)
    size_param = "?s=#{size}"

    gravatar_base_url + hash + size_param
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
