require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build Inquiry Params ===
trx_id = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)
inquiry_params = {
  "iMid" => "TNICEALL01",
  "tXid" => "TNICEALL0102202512231833120618",
  "amt" => "10000",
  "referenceNo" => "ordNo20251223181283"
}

# === STEP 2: Call Inquiry V1 ===
inquiry = NicepayRuby::Builder::V1::Inquiry.new(inquiry_params)
response = inquiry.check_status

puts "[REQUEST PARAMS] #{JSON.pretty_generate(inquiry_params)}"
puts "[RESPONSE] #{response}"
