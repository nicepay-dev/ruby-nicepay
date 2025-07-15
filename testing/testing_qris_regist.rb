# testing/testing_qris_register.rb

require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/qris_regist'
require 'json'

client_id     = "TNICEQR081"
client_secret = NicepayCredential.client_secret
private_key   = NicepayCredential.private_key
channel_id    = "123456"
timestamp     = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id   = SignatureGeneratorUtils.generate_random_number_string(8)
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

# STEP 3: Build QRIS Registration Request
builder = QrisRegistrationBuilder.new
additional_info = {
  "goodsNm" => "Test SNAP Transaction Nicepay",
  "billingNm" => "John Doe",
  "billingPhone" => "082213561712",
  "billingEmail" => "email@merchant.com",
  "billingCity" => "Jakarta",
  "billingAddr" => "Jalan Bukit Berbunga 22",
  "billingState" => "DKI Jakarta",
  "billingPostCd" => "12345",
  "billingCountry" => "Indonesia",
  "mitraCd" => "QSHP",
  "callBackUrl" => "https://ptsv2.com/t/jhon/post",
  "dbProcessUrl" => "https://ptsv2.com/t/jhon/post",
  "userIP" => "127.0.0.1",
  "cartData" => "{\"count\":1,\"item\":[{\"img_url\":\"https://d3nevzfk7ii3be.cloudfront.net/igi/vOrGHXlovukA566A.medium\",\"goods_name\":\"Nokia 3360\",\"goods_detail\":\"Old Nokia 3360\",\"goods_amt\":\"100\",\"goods_quantity\":\"1\"}]}",
  "msId" => "",
  "msFee" => "",
  "msFeeType" => "",
  "mbFee" => "",
  "mbFeeType" => ""
}

request_body = builder.set_qris_registration(
  partner_reference_no: "ord" + timestamp ,
  amount_value: "100.00",
  currency: "IDR",
  merchant_id: client_id,
  store_id: "NICEPAY",
  validity_period: "",
  additional_info: additional_info
).build

# STEP 4: Kirim ke API
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(
  endpoints.generate_qris,
  access_token,
  timestamp,
  request_body,
  external_id
)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
