require_relative "../lib/nicepay_ruby"
require 'json'

# def initialize
#     @client_id = NicepayCredential.client_id
#     @signature_generator = SignatureGeneratorUtils.new
#   end
# === CONFIGURATION ===
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


# STEP 3: Build QRIS Registration Request
builder = NicepayRuby::QrisSnapBuilder.new
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

request_body = builder.set_qris_snap(
  partner_reference_no: "ord" + timestamp ,
  amount_value: "100.00",
  currency: "IDR",
  merchant_id: client_id,
  store_id: "NICEPAY",
  validity_period: "",
  additional_info: additional_info
).build

# STEP 4: Kirim ke API
endpoints = NicepayRuby::ApiEndpoints.new
service = NicepayRuby::ServiceApi.new(
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
