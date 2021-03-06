require 'camp3'

Camp3.configure do |config|
    config.client_id = ENV['BASECAMP3_CLIENT_ID']
    config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
    config.redirect_uri = ENV['BASECAMP3_REDIRECT_URI']
end

# Get the authorization uri
puts Camp3.authorization_uri

# Once you have received the auth code from basecamp, you can proceed with the following step
# This will update the configuration with the corresponding tokens
# Store the tokens in a safe place
token = Camp3.authorize! ENV['BASECAMP3_ACCESS_CODE']

# Print refresh token
puts token.refresh_token

# Print access token
puts token.access_token

