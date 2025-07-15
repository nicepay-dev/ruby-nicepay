# testing/testing_ewallet_inquiry.rb

require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/ewallet_inquiry'
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
body_builder = EwalletInquiryBuilder.new
request_body = body_builder.set_ewallet_inquiry(
  merchant_id: "NORMALTEST",
  sub_merchant_id: "",
  original_partner_reference_no: "2020102900000000000001",
  original_reference_no: "NORMALTEST05202507071000566469",
  service_code: "54",
  transaction_date: "",
  external_store_id: "",
  amount_value: "10000.00",
  currency: "IDR"
).build

# STEP 4: Call Inquiry via APIService
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.status_ewallet, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
