require_relative "../lib/nicepay_ruby"
require "json"

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

# === STEP 1: Build Cancel Params ===
cancel_params = {
  "tXid" => "TNICEALL0102202512231833120618",
  "payMethod" => "02",
  "amt" => "10000",
  "fee" => "0",
  "vat" => "0",
  "notaxAmt" => "0",
  "reqServerIP" => "127.0.0.1",
  "cancelUserId" => "",
  "userIP" => "127.0.0.1",
  "cancelUserInfo" => "Customer cancel transaction",
  "worker" => "",
  "cancelMsg" => "Cancel Message",
  "cancelType" => "1"
}

# === STEP 2: Call Cancel V1 ===
cancel = NicepayRuby::Builder::V1::Cancel.new(cancel_params)
response = cancel.cancel

puts "[REQUEST PARAMS] #{JSON.pretty_generate(cancel_params)}"
puts "[RESPONSE] #{response}"
