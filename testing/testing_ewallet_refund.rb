# testing/testing_ewallet_refund.rb

require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/ewallet_refund'
require 'json'

client_id     = NicepayCredential.client_id
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(8)
is_production = false
is_cloud      = false

# STEP 1: Generate Signature
signature = SignatureGeneratorUtils.generate_signature(private_key, client_id, timestamp)

# STEP 2: Get Access Token
client = AccessTokenClient.new(
  client_id: client_id,
  private_key: private_key,
  is_production: is_production,
  is_cloud_server: is_cloud
)
result = client.request_access_token
access_token = result["accessToken"]

# STEP 3: Build Body
builder = NicepayRuby::EwalletSnapBuilder.new
request_body = builder.set_ewallet_refund(
  merchant_id: "NORMALTEST",
  sub_merchant_id: "",
  original_partner_reference_no: "2020102900000000000001",
  original_reference_no: "NORMALTEST05202507071000566469",
  partner_refund_no: "239850918204981205970",
  refund_amount_value: "10000.00",
  currency: "IDR",
  external_store_id: "",
  reason: "Customer Request",
  refund_type: "1"
).build

# STEP 4: Send Request
endpoints = ApiEndpoints.new
service = ServiceSnap.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.refund_ewallet, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
