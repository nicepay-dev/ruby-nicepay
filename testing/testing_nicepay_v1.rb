require_relative "../lib/nicepay_ruby"
require "json"


# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = 'TNICEALL01'
  config.merchant_key   = '33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=='
  config.is_production  = false
  config.is_cloud_server = false
end


# === STEP 1: Build Payment Params ===
trx_id = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)
payment_params = {
  "iMid" => "TNICEALL01",
  "payMethod" => "01",
  "currency" => "IDR",
  "amt" => "1000",
  "instmntMon" => "1",
  "referenceNo" => trx_id,
  "goodsNm" => "Merchant Goods 1",
  "billingNm" => "John Doe",
  "billingEmail" => "buyer@merchant.com",
  "billingPhone" => "081234567890",
  "billingAddr" => "Billing Address",
  "billingCity" => "Jakarta",
  "billingState" => "Jakarta",
  "billingPostCd" => "12345",
  "billingCountry" => "Indonesia",
  "deliveryNm" => "John Doe Delivery",
  "deliveryPhone" => "081234567890",
  "deliveryAddr" => "Billing Address ",
  "deliveryCity" => "Jakarta",
  "deliveryState" => "Jakarta",
  "deliveryPostCd" => "12345",
  "deliveryCountry" => "Indonesia",
  "callBackUrl" => "https://merchant.com/api/callBackUrl",
  "dbProcessUrl" => "https://merchant.com/api/dbProcessUrl/Notif",
  "vat" => "0",
  "fee" => "0",
  "notaxAmt" => "0",
  "description" => "Description",
  "userIP" => "127.0.0.1",
  "shopId" => "NICEPAY",
  "cartData" => "{}",
  "instmntType" => "1",
  "reccurOpt" => "0",
  "reqDt" => "20160301",
  "reqTm" => "135959",
  "reqDomain" => "www.merchant.com",
  "reqServerIP" => "127.0.0.1",
  "reqClientVer" => "1.0",
  "userSessionID" => "userSessionID",
  "userAgent" => "Mozilla",
  "userLanguage" => "en-US",
  "merFixAcctId" => "9999000000000001",
  "vacctValidDt" => "20160303",
  "vacctValidTm" => "135959",
  "paymentExpiryDt" => "20160303",
  "paymentExpiryTm" => "135959"
}


# === STEP 2: Call Registration V1 ===
registration = NicepayRuby::Builder::V1::Registration.new(payment_params)
response = registration.register

puts "[REQUEST PARAMS] #{JSON.pretty_generate(payment_params)}"
puts "[RESPONSE] #{response}"
