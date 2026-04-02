require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build Ewallet Regist Params ===
trx_id = "OrdNo-" + Time.now.strftime("%Y%m%d%H%M%S")
ewallet_params = {
  "iMid" => "IONPAYTEST",
  "payMethod" => "05",
  "currency" => "IDR",
  "amt" => "5000",
  "referenceNo" => trx_id,
  "goodsNm" => "Jhon Doe S",
  "billingNm" => "Jhon Doe",
  "billingPhone" => "085695655726",
  "billingEmail" => "test@email.com",
  "callBackUrl" => "https://webhook.site/e1e151bc-23f5-4db9-8272-6addeea95701",
  "dbProcessUrl" => "https://webhook.site/e1e151bc-23f5-4db9-8272-6addeea95701",
  "description" => "This is Testing Transaction",
  "mitraCd" => "ESHP",
  "userIP" => "::1",
  "billingCity" => "Nicepay City",
  "billingAddr" => "Nicepay Company",
  "billingCountry" => "Jakarta",
  "billingState" => "Nicepay State",
  "billingPostCd" => "12345",
  "cartData" => '{"count":"1","item":[{"img_url":"https://d3nevzfk7ii3be.cloudfront.net/igi/vOrGHXlovukA566A.medium","goods_name":"Nokia 3360","goods_detail":"Old Nokia 3360","goods_amt":"5000","goods_quantity":"1"}]}',
  "returnJsonFormat" => "1"
}

# === STEP 2: Call Ewallet Regist V1 ===
ewallet = NicepayRuby::Builder::V1::Ewallet.new(ewallet_params)
response = ewallet.regist

puts "[REQUEST PARAMS] #{JSON.pretty_generate(ewallet_params)}"
puts "[RESPONSE] #{response}"
