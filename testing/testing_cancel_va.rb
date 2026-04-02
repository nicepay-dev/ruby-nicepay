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
signature = "4TRe5URKoFXkHF+e/1ipNh4qWDYrx2OwWIjWQTaOic716yvpvR+p79Th8pkEBlQGAOCXK8gA2dQKI3ia/jIaog=="

# === STEP 2: Get Access Token ===
# client = NicepayRuby::AccessTokenClient.new
# result = client.request_access_token
# access_token = result["accessToken"]
access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTRVJCQU0wMDAxIiwiaXNzIjoiTklDRVBBWSIsIm5hbWUiOiJmVnhuQWoxSldQIiwiZXhwIjoiMjAyNi0wMy0zMFQwNzowMzo1NVoifQ==.m50cwBEJVo3lzHtCIrSqpZ2paJB_gceEJ2_SoEXF5FM="


# STEP 3: Build Body
cancel_builder = NicepayRuby::VirtualAccountBuilder.new
request_body = cancel_builder.set_virtual_account_cancel(
  partner_service_id: "",
  customer_no: "",
  virtual_account_no: "7001400002022393",
  trx_id: "20260330102330",
  value: "10000.00",
  currency: "IDR",
  tXid_va: "SERBAM000102202603301023290732",
  cancel_message: "Cancel Virtual Account Test"
).build

# STEP 4: Call Cancel VA via APIService (DELETE)
endpoints = NicepayRuby::ApiEndpoints.new
service = NicepayRuby::ServiceApi.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_delete_request(endpoints.delete_va, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
