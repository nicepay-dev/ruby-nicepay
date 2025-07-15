# testing/testing_ewallet_payment.rb

require_relative '../api_endpoints'
require_relative '../service_api'
require_relative '../nicepay_credential'
require_relative '../signature_generator'
require_relative '../access_token_client'
require_relative '../builder/ewallet_regist'
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
body_builder = EwalletPaymentBuilder.new
request_body = body_builder.set_ewallet_payment(
  partner_reference_no: "2020102900000000000001",
  merchant_id: "NORMALTEST",
  sub_merchant_id: "310928924949487",
  amount_value: "10000.00",
  currency: "IDR",
  url_param: [
    {
      "url" => "https://test1.bi.go.id/v1/test",
      "type" => "PAY_NOTIFY",
      "isDeeplink" => "Y"
    },
    {
      "url" => "https://test2.bi.go.id/v1/test",
      "type" => "PAY_RETURN",
      "isDeeplink" => "Y"
    }
  ],
  external_store_id: "",
  valid_up_to: "",
  point_of_initiation: "Mobile App",
  mitra_cd: "DANA",
  goods_nm: "Merchant Goods 1",
  billing_nm: "Buyer Name",
  billing_phone: "02112345678",
  billing_email: "jhondoe@gmail.com",
  call_back_url: "http://www.merchant.com/callback",
  db_process_url: "http://www.merchant.com/notification",
  cart_data: {
    "count" => "2",
    "item" => [
      {
        "img_url" => "http://img.aaa.com/ima1.jpg",
        "goods_name" => "Item 1 Name",
        "goods_detail" => "Item 1 Detail",
        "goods_amt" => "0.00",
        "goods_quantity" => "1"
      },
      {
        "img_url" => "http://img.aaa.com/ima2.jpg",
        "goods_name" => "Item 2 Name",
        "goods_detail" => "Item 2 Detail",
        "goods_amt" => "10000.00",
        "goods_quantity" => "1"
      }
    ]
  }.to_json
).build

# STEP 4: Send request
endpoints = ApiEndpoints.new
service = APIService.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.payment_ewallet, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
