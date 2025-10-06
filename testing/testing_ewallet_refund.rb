require_relative "../lib/nicepay_ruby"
require 'json'

NicepayRuby.configure do |config|
  config.client_id     = ""
  config.private_key   = ""
  config.client_secret = ""
  config.channel_id    = "123456"
  config.partner_id    = ""
  config.is_production = false
  config.is_cloud_server = false
end

client_id     = NicepayRuby.configuration.client_id
client_secret = NicepayRuby.configuration.client_secret
private_key   = NicepayRuby.configuration.private_key
channel_id    = NicepayRuby.configuration.channel_id
is_production = NicepayRuby.configuration.is_production
is_cloud = NicepayRuby.configuration.is_cloud_server

timestamp   = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id = NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(8)
trx_id      = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)



# === STEP 1: Generate Signature ===
signature = NicepayRuby::SignatureGeneratorUtils.generate_signature(private_key, client_id, timestamp)

# === STEP 2: Get Access Token ===
client = NicepayRuby::AccessTokenClient.new
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
endpoints = NicepayRuby::ApiEndpoints.new
service = NicepayRuby::ServiceApi.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.refund_ewallet, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
