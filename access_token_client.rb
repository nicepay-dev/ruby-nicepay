require_relative 'nicepay_credential'
require_relative 'signature_generator'
require_relative 'api_endpoints'
require 'net/http'
require 'uri'
require 'json'

class AccessTokenClient
  # def initialize(is_production: false)
  #   @client_id = NicepayCredential.client_id
  #   @private_key_base64 = NicepayCredential.private_key
  #   @url = is_production ?
  #          'https://www.nicepay.co.id/nicepay/v1.0/access-token/b2b' :
  #          'https://dev.nicepay.co.id/nicepay/v1.0/access-token/b2b'
  # end

  def initialize(client_id:, private_key:, is_production:, is_cloud_server:)
    @client_id = client_id
    @private_key = private_key
    NICEPayBuilder.set_environment(production: is_production, cloud_server: is_cloud_server)
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

  
  def build_full_url(endpoint)
    base_url = NICEPayBuilder.get_base_url
    URI.join(base_url, endpoint).to_s
  end
end
