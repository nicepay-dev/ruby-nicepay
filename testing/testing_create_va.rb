require_relative "../lib/nicepay_ruby"
require 'json'

# def initialize
#     @client_id = NicepayCredential.client_id
#     @signature_generator = SignatureGeneratorUtils.new
#   end
# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id     = "SERBAM0001"
  config.private_key   = ""
  config.client_secret = "qr7fBNIqMK25kyZktzD9ukymix3AU/VA4EeKLILWEOA5shqYC+4Lkk0zIfbiXNBZBP8Be40p9TwiFSLaikK92A=="
  config.channel_id    = "SERBAM000101"
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
# signature = NicepayRuby::SignatureGeneratorUtils.generate_signature(private_key, client_id, timestamp)

# === STEP 2: Get Access Token ===
# client = NicepayRuby::AccessTokenClient.new
# result = client.request_access_token
access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTRVJCQU0wMDAxIiwiaXNzIjoiTklDRVBBWSIsIm5hbWUiOiJmVnhuQWoxSldQIiwiZXhwIjoiMjAyNi0wMy0zMFQwNzowMzo1NVoifQ==.m50cwBEJVo3lzHtCIrSqpZ2paJB_gceEJ2_SoEXF5FM="


# STEP 3: Build Body VA
body_builder = NicepayRuby::VirtualAccountBuilder.new
request_body = body_builder.set_virtual_account_snap(
  partner_service_id: "",
  customer_no: "",
  virtual_account_name: "Ruby Plugin Test",
  trx_id: trx_id,
  value: "10000.00",
  currency: "IDR",
  bank_cd: "BNIN",
  goods_nm: "Ruby Test Item",
  db_process_url: "https://nicepay.co.id/"
).build

# STEP 4: Call Create VA via APIService
endpoints = NicepayRuby::ApiEndpoints.new
service = NicepayRuby::ServiceApi.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud)
response = service.send_post_request(endpoints.create_va, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
