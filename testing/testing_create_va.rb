require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/virtual_account_regist'
require 'json'

# def initialize
#     @client_id = NicepayCredential.client_id
#     @signature_generator = SignatureGeneratorUtils.new
#   end
# Simulasi environment & config
client_id     = NicepayCredential.client_id
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(8)
trx_id        = "trxId" + SignatureGeneratorUtils.generate_random_number_string(6)
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


# STEP 3: Build Body VA
body_builder = VirtualAccountBuilder.new
request_body = body_builder.set_virtual_account_snap(
  partner_service_id: "",
  customer_no: "",
  virtual_account_name: "Ruby Plugin Test",
  trx_id: trx_id,
  value: "10000.00",
  currency: "IDR",
  bank_cd: "CENA",
  goods_nm: "Ruby Test Item",
  db_process_url: "https://nicepay.co.id/"
).build

# STEP 4: Call Create VA via APIService
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud)
response = service.send_post_request(endpoints.create_va, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
