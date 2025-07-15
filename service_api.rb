require 'net/http'
require 'uri'
require 'json'
require_relative 'signature_generator'
require_relative 'nicepay_builder'
require_relative 'api_endpoints'
require_relative 'nicepay_credential'

class APIService
  def initialize(client_id:, client_secret:, channel_id:, is_production:, is_cloud_server:)
    @client_id = client_id
    @client_secret = client_secret
    @channel_id = channel_id
    NICEPayBuilder.set_environment(production: is_production, cloud_server: is_cloud_server)
  end

  def send_post_request(endpoint, access_token, timestamp, request_body, external_id)
    signature = SignatureGeneratorUtils.get_signature("POST", access_token, request_body, endpoint, timestamp, @client_secret)
    full_url = build_full_url(endpoint)
    puts full_url

    uri = URI(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "X-TIMESTAMP" => timestamp,
      "X-SIGNATURE" => signature,
      "Authorization" => "Bearer #{access_token}",
      "X-PARTNER-ID" => @client_id,
      "X-EXTERNAL-ID" => external_id,
      "CHANNEL-ID" => @channel_id,
      "Content-Type" => "application/json"
    }

    puts headers

    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = request_body.to_json

    response = http.request(request)
    response.body
  end

  def send_delete_request(endpoint, access_token, timestamp, request_body, external_id)
    signature = SignatureGeneratorUtils.get_signature("DELETE", access_token, request_body, endpoint, timestamp, @client_secret)
    full_url = build_full_url(endpoint)
    puts full_url
    uri = URI(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "X-TIMESTAMP" => timestamp,
      "X-SIGNATURE" => signature,
      "Authorization" => "Bearer #{access_token}",
      "X-PARTNER-ID" => @client_id,
      "X-EXTERNAL-ID" => external_id,
      "CHANNEL-ID" => @channel_id,
      "Content-Type" => "application/json"
    }

    request = Net::HTTP::Delete.new(uri.path, headers)
    request.body = request_body.to_json

    response = http.request(request)
    response.body
  end

  private

  def build_full_url(endpoint)
    base_url = NICEPayBuilder.get_base_url
    URI.join(base_url, endpoint).to_s
  end
end
