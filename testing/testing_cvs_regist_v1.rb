require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build CVS Regist Params ===
trx_id = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)
cvs_params = {
  "iMid" => "TNICEALL01",
  "payMethod" => "03",
  "currency" => "IDR",
  "amt" => "1000",
  "referenceNo" => trx_id,
  "mitraCd" => "ALMA",
  "goodsNm" => "Merchant Goods 1",
  "billingNm" => "John Doe",
  "billingEmail" => "buyer@merchant.com",
  "billingPhone" => "081234567890",
  "billingAddr" => "Billing Address",
  "billingCity" => "Jakarta",
  "billingState" => "Jakarta",
  "billingPostCd" => "12345",
  "billingCountry" => "Indonesia",
  "deliveryNm" => "John Doe",
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
  "payValidDt" => "",
  "payValidTm" => ""
}

# === STEP 2: Call CVS Regist V1 ===
cvs = NicepayRuby::Builder::V1::CVS.new(cvs_params)
response = cvs.regist

puts "[REQUEST PARAMS] #{JSON.pretty_generate(cvs_params)}"
puts "[RESPONSE] #{response}"
