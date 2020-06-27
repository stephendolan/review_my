# Learn about sending emails
# https://luckyframework.org/guides/emails/sending-emails-with-carbon
abstract class BaseEmail < Carbon::Email
  macro inherited
    from default_from
  end

  def default_from
    Carbon::Address.new("ReviewMy Support", "support@reviewmy.email")
  end
end
