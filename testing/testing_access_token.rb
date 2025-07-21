require_relative '../access_token_client'

client = AccessTokenClient.new
result = client.request_access_token
access_token = result["accessToken"]
puts access_token
