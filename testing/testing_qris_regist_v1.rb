require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build QRIS Regist Params ===
trx_id = "ORDER" + Time.now.strftime("%d%m")
qris_params = {
  "iMid" => "IONPAYTEST",
  "payMethod" => "08",
  "currency" => "IDR",
  "amt" => "1000",
  "referenceNo" => trx_id,
  "goodsNm" => "Test Transaction Nicepay",
  "billingNm" => "John Doe",
  "billingPhone" => "081234567890",
  "billingEmail" => "Email@customer.com",
  "billingCity" => "Jakarta",
  "billingState" => "DKI Jakarta",
  "billingPostCd" => "14350",
  "billingCountry" => "Indonesia",
  "callBackUrl" => "https://merchant.com/api/callBackUrl",
  "dbProcessUrl" => "https://merchant.com/api/dbProcessUrl/Notif",
  "mitraCd" => "QSHP",
  "cartData" => '{"count":1,"item":[{"img_url":"https://images.com/image.png","goods_name":"Shoe","goods_detail":"Shoe","goods_amt":1000}]}',
  "shopId" => "NICEPAY",
  "userIP" => "::127.0.0.1"
}

# === STEP 2: Call QRIS Regist V1 ===
qris = NicepayRuby::Builder::V1::QRIS.new(qris_params)
response = qris.regist

puts "[REQUEST PARAMS] #{JSON.pretty_generate(qris_params)}"
puts "[RESPONSE] #{response}"
