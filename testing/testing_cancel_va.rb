# testing/testing_cancel_va.rb

require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/virtual_account_cancel'
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
cancel_builder = VirtualAccountCancelBuilder.new
request_body = cancel_builder.set_virtual_account_cancel(
  partner_service_id: "",
  customer_no: "",
  virtual_account_no: "9912304000064179",
  trx_id: "trxId214331",
  value: "10000.00",
  currency: "IDR",
  tXid_va: "NORMALTEST02202507070646466329",
  cancel_message: "Cancel Virtual Account Ruby"
).build

# STEP 4: Call Cancel VA via APIService (DELETE)
endpoints = ApiEndpoints.new
service = ServiceSnap.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_delete_request(endpoints.delete_va, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
