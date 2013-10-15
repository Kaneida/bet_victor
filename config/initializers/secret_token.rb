# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

if Figaro.env.try(:secret_token).present?
  BetVictor::Application.config.secret_token = Figaro.env.secret_token
else
  puts "ENV['SECRET_TOKEN'] not found. Generate one with `rake secret` and set it in ENV['SECRET_TOKEN'] or application.yml"
end
