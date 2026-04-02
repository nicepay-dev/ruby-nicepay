
require 'net/http'
require 'uri'
require 'json'
require_relative 'signatureUtils'

module NicepayRuby
  class ServiceApi
    def initialize(endpoints: nil, client_id: nil, client_secret: nil, channel_id: nil, is_production:, is_cloud_server:)
      @endpoints = endpoints
      @client_id = client_id
      @client_secret = client_secret
      @channel_id = channel_id
      @is_production = is_production
      @is_cloud_server = is_cloud_server

      # Set environment global
      NicepayRuby::Config.set_environment(
        production: is_production,
        cloud_server: is_cloud_server
      )
    end


      # ==============================
    # V1: Simple POST x-www-form-urlencoded
    # ==============================
    def send_post_form(endpoint, form_data)
      full_url = build_url(endpoint)
      puts "[DEBUG][V1 POST FORM] endpoint: #{full_url}"

      begin
        uri = URI(full_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"

        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data(form_data)

        response = http.request(request)
        body = response.body
        response.is_a?(Net::HTTPSuccess) ? body : "Error: #{response.code} - #{response.message}\nResponse: #{body}"
      rescue => e
        "Exception occurred: #{e.message}"
      end
    end

    # ==============================
    # NON-SNAP (simple POST request)
    # ==============================
    def send_post(endpoint, request_body)
      return "Error: Request body is null or empty." if request_body.nil? || request_body.empty?

      full_url = build_url(endpoint)
      puts "[DEBUG] endpoint: #{full_url}"

      begin
        json_body = request_body.to_json
        uri = URI(full_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"

        headers = { "Content-Type" => "application/json" }
        request = Net::HTTP::Post.new(uri.request_uri, headers)
        request.body = json_body

        response = http.request(request)
        body = response.body

        response.is_a?(Net::HTTPSuccess) ? body : "Error: #{response.code} - #{response.message}\nResponse: #{body}"
      rescue => e
        "Exception occurred: #{e.message}"
      end
    end
    

    # ==============================
    # SNAP (secure request w/ signature)
    # ==============================
    def send_post_request(endpoint, access_token, timestamp, request_body, external_id)
      signature = SignatureGeneratorUtils.get_signature(
        "POST", access_token, request_body, endpoint, timestamp, @client_secret
      )
      full_url = build_full_url(endpoint)
      puts "[DEBUG][SNAP POST] #{full_url}"

      uri = URI(full_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      headers = build_snap_headers(signature, access_token, timestamp, external_id)
      request = Net::HTTP::Post.new(uri.path, headers)
      request.body = request_body.to_json

      response = http.request(request)
      response.body
    end

    def send_delete_request(endpoint, access_token, timestamp, request_body, external_id)
      signature = SignatureGeneratorUtils.get_signature(
        "DELETE", access_token, request_body, endpoint, timestamp, @client_secret
      )
      full_url = build_full_url(endpoint)
      puts "[DEBUG][SNAP DELETE] #{full_url}"

      uri = URI(full_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      headers = build_snap_headers(signature, access_token, timestamp, external_id)
      request = Net::HTTP::Delete.new(uri.path, headers)
      request.body = request_body.to_json

      response = http.request(request)
      response.body
    end

    private

    # ===== Non-snap builder =====
    def build_url(endpoint)
      base_url = if @is_cloud_server
                   @is_production ? NicepayRuby::Config.get_production_cloud : NicepayRuby::Config.get_sandbox_cloud
                 else
                   @is_production ? NicepayRuby::Config.get_production_base_url : NicepayRuby::Config.get_sandbox_base_url
                 end
      URI.join(base_url, endpoint).to_s
    end

    # ===== Snap builder =====
    def build_full_url(endpoint)
      base_url = NicepayRuby::Config.base_url
      URI.join(base_url, endpoint).to_s
    end

    def build_snap_headers(signature, access_token, timestamp, external_id)
      {
        "X-TIMESTAMP"   => timestamp,
        "X-SIGNATURE"   => signature,
        "Authorization" => "Bearer #{access_token}",
        "X-PARTNER-ID"  => @client_id,
        "X-EXTERNAL-ID" => external_id,
        "CHANNEL-ID"    => @channel_id,
        "Content-Type"  => "application/json"
      }
    end
  end
end
