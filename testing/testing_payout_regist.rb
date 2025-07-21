require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/payout_regist'
require 'json'

# Konfigurasi
client_id     = NicepayCredential.client_id
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(6)
trx_id        = "order" + Time.now.to_i.to_s
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
builder = PayoutRegistrationBuilder.new
request_body = builder.set_payout_registration(
  merchant_id: "NORMALTEST",
  ms_id: "",
  beneficiary_account_no: "5345000060",
  beneficiary_name: "IONPAY NETWORKS",
  beneficiary_phone: "08123456789",
  beneficiary_residence: "1",
  beneficiary_type: "1",
  beneficiary_postal_code: "123456",
  payout_method: "0",
  beneficiary_bank_code: "CENA",
  amount_value: "12345678.00",
  partner_reference_no: trx_id,
  description: "This is test Request",
  reserved_dt: Time.now.strftime('%Y%m%d'),
  reserved_tm: Time.now.strftime('%H%M%S')
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

response = service.send_post_request(endpoints.create_payout, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
