require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build VA Regist Params ===
trx_id = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)
va_params = {
  "iMid" => "IONPAYTEST",
  "payMethod" => "02",
  "currency" => "IDR",
  "amt" => "10000",
  "referenceNo" => trx_id,
  "bankCd" => "BMRI",
  "goodsNm" => "Merchant Goods 1",
  "billingNm" => "John Doe",
  "billingEmail" => "buyer@merchant.com",
  "billingPhone" => "08123456789",
  "billingAddr" => "Billing Address",
  "billingCity" => "Jakarta",
  "billingState" => "Jakarta",
  "billingPostCd" => "12345",
  "billingCountry" => "Indonesia",
  "deliveryNm" => "John Doe Delivery",
  "deliveryPhone" => "081234567890",
  "deliveryAddr" => "Billing Address ",
  "deliveryCity" => "Jakarta ",
  "deliveryState" => "Jakarta ",
  "deliveryPostCd" => "12345",
  "deliveryCountry" => "Indonesia ",
  "callBackUrl" => "https://merchant.com/callback",
  "dbProcessUrl" => "https://merchant.com/dbprocess",
  "vat" => "0",
  "fee" => "0",
  "notaxAmt" => "0",
  "description" => "Description",
  "userIP" => "127.0.0.1",
  "cartData" => "{}",
  "reqDt" => "20160301",
  "reqTm" => "135959",
  "reqDomain" => "merchant.com",
  "reqServerIP" => "127.0.0.1",
  "reqClientVer" => "1.0",
  "userSessionID" => "userSessionID",
  "userAgent" => "Mozilla",
  "userLanguage" => "en-US",
  "merFixAcctId" => "",
  "paymentExpiryDt" => "",
  "paymentExpiryTm" => "",
  "vacctValidDt" => "",
  "vacctValidTm" => ""
}

# === STEP 2: Call VA Regist V1 ===
va = NicepayRuby::Builder::V1::VA.new(va_params)
response = va.regist

puts "[REQUEST PARAMS] #{JSON.pretty_generate(va_params)}"
puts "[RESPONSE] #{response}"
