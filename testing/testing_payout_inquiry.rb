require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/payout_inquiry'
require 'json'

# Konfigurasi
client_id     = NicepayCredential.client_id
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(6)
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

# STEP 3: Build Request Body
builder = PayoutInquiryBuilder.new
request_body = builder.set_payout_inquiry(
  merchant_id: "IONPAYTEST",
  original_reference_no: "IONPAYTEST07202302221348332909",
  original_partner_reference_no: "order1677048512514",
  beneficiary_account_no: "8457349857498578"
).build

# STEP 4: Call API
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.inquiry_payout, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
