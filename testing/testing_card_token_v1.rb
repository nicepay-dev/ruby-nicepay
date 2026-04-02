# frozen_string_literal: true

require_relative '../lib/nicepay_ruby'

# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id      = ""
  config.merchant_key   = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="
  config.is_production  = false
  config.is_cloud_server = false
end

params = {
  'iMid' => 'IONPAYTEST',
  'referenceNo' => 'MerchantReferenceNumber001',
  'amt' => '10000',
  'cardHolderNm' => 'John Doe',
  'cardHolderEmail' => 'johndoe@gmail.com',
  'cardNo' => '5123450000000008',
  'cardExpYymm' => '3901',
  'merchantKey' => 'your_merchant_key' # Ganti dengan merchantKey asli
}

# Set environment jika perlu
# NicepayRuby::Config.set_environment(production: false, cloud_server: false)

response = NicepayRuby::Builder::V1::CardToken.new(params).request_token
puts response
