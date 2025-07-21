require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/qris_refund'
require 'json'

# Konfigurasi
client_id     = "TNICEQR081"
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(6)
is_production = false
is_cloud      = false

# STEP 1: Signature
signature = SignatureGeneratorUtils.generate_signature(private_key, client_id, timestamp)

# STEP 2: Access Token
client = AccessTokenClient.new(
  client_id: client_id,
  private_key: private_key,
  is_production: is_production,
  is_cloud_server: is_cloud
)
result = client.request_access_token
access_token = result["accessToken"]

# STEP 3: Build Request Body
builder = QrisRefundBuilder.new
request_body = builder.set_qris_refund(
  original_reference_no: "ncpy20221017161458",
  original_partner_reference_no: "TNICEQR08108202507082238381348",
  partner_refund_no: "ord2025-07-08T22:38:31+07:00",
  merchant_id: "TNICEQR081",
  external_store_id: "NICEPAY",
  refund_value: "10000.00",
  reason: "Refund Trans",
  additional_info: {
    cancelType: "1"
  }
).build

# STEP 4: Hit API
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.refund_qris, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
