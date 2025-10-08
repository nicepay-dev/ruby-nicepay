
require_relative 'signatureUtils'
require_relative 'nicepayConstant'
require 'net/http'
require 'uri'
require 'json'

module NicepayRuby
class AccessTokenClient
  # def initialize(is_production: false)
  #   @client_id = NicepayCredential.client_id
  #   @private_key_base64 = NicepayCredential.private_key
  #   @url = is_production ?
  #          'https://www.nicepay.co.id/nicepay/v1.0/access-token/b2b' :
  #          'https://dev.nicepay.co.id/nicepay/v1.0/access-token/b2b'
  # end

  def initialize(client_id: nil, private_key: nil, is_production: nil, is_cloud_server: nil)
      config = NicepayRuby.configuration

      @client_id   = client_id   || config.client_id
      @private_key = private_key || config.private_key
      @is_production  = is_production.nil?  ? config.is_production  : is_production
      @is_cloud_server = is_cloud_server.nil? ? config.is_cloud_server : is_cloud_server

      Config.set_environment(
      production: @is_production,
      cloud_server: @is_cloud_server
      )
  end

  def request_access_token
    timestamp = Time.now.getlocal('+07:00').strftime('%Y-%m-%dT%H:%M:%S%:z')
    signature = SignatureGeneratorUtils.generate_signature(@private_key, @client_id, timestamp)
    endpoints = ApiEndpoints.new
    full_url = build_full_url(endpoints.access_token)
    puts full_url
    uri = URI(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      'Content-Type' => 'application/json',
      'X-CLIENT-KEY' => @client_id,
      'X-TIMESTAMP' => timestamp,
      'X-SIGNATURE' => signature
    }

    request = Net::HTTP::Post.new(uri, headers)
    request.body = { grantType: 'client_credentials' }.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end

  
  def build_full_url(path)
  base_url = NicepayRuby::Config.base_url
  "#{base_url}#{path}"
  end

end
end