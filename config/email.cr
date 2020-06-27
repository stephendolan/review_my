BaseEmail.configure do |settings|
  if Lucky::Env.production? || Lucky::Env.development?
    send_grid_key = send_grid_key_from_env
    settings.adapter = Carbon::SendGridAdapter.new(api_key: send_grid_key)
  else
    settings.adapter = Carbon::DevAdapter.new
  end
end

private def send_grid_key_from_env
  ENV["SEND_GRID_KEY"]? || raise_missing_key_message
end

private def raise_missing_key_message
  puts "Missing SEND_GRID_KEY. Set the SEND_GRID_KEY env variable to 'unused' if not sending emails, or set the SEND_GRID_KEY ENV var.".colorize.red
  exit(1)
end
