require_relative "../lib/nicepay_ruby"
require "json"

# ✅ Build payload
NicepayRuby.configure do |config|
  config.client_id       = "IONPAYTEST"  # iMid
  config.merchant_key    = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A=="  # Merchant Key dari Nicepay
  config.is_production = false
  config.is_cloud_server = false
end

client_id    = NicepayRuby.configuration.client_id
merchant_key = NicepayRuby.configuration.merchant_key

# === COMMON DATA ===
amount      = "10000"
reference_no = "REF" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(8)
timestamp    = Time.now.strftime("%Y%m%d%H%M%S")

token_builder = NicepayRuby::MerchantTokenGenerate.new
  .set_time_stamp(timestamp)
  .set_imid(client_id)
  .set_ref_no(reference_no)
  .set_amount(amount)
  .set_merchant_key(merchant_key)

merchant_token = token_builder.build_merchant_token
# === STEP 2: Build Body ===
builderCC = NicepayRuby::CCRegistrationBuilder.new
request_body = builderCC.set_cc_regist(
 i_mid: client_id,
  time_stamp: timestamp,
  pay_method: "01", # QRIS
  currency: "IDR",
  amt: amount,
  reference_no: reference_no,
  goods_nm: "Ruby Test CC",
  merchant_token: merchant_token,
  instmnt_type: "1",
  instmnt_mon: "1",
  recurr_opt: "",
  billing_nm: "John Doe",
  billing_phone: "08123456789",
  billing_email: "john@example.com",
  billing_addr: "Jl. Sudirman No.1",
  billing_city: "Jakarta",
  billing_state: "DKI",
  billing_post_cd: "12345",
  billing_country: "ID",
  call_back_url: "https://www.nicepay.co.id/IONPAY_CLIENT/paymentResult.jsp",
  db_process_url: "https://merchant.com/callback",
  cart_data: {
    count: "1",
    item: [
      {
        goods_id: "BB12345678",
        goods_detail: "BB12345678",
        goods_name: "Pasar Modern",
        goods_amt: amount,
        goods_type: "Sembako",
        goods_url: "http://merchant.com/cellphones/iphone5s_64g",
        goods_quantity: "1",
        goods_sellers_id: "SEL123",
        goods_sellers_name: "Sellers 1"
      }
    ]
  }.to_json,
  description: "testing CC ruby",
  user_ip: "127.0.0.1",
  user_agent: "Mozilla/5.0",
  user_language: "en"
).build

puts "📦 Request Regist: #{request_body.to_json}"

# ✅ Setup endpoints
api_endpoints = NicepayRuby::ApiEndpoints.new

# ✅ Setup service
service = NicepayRuby::ServiceApi.new(
  endpoints: api_endpoints,
  is_production: false,
  is_cloud_server: false
)

# ✅ Call registration API
result = service.send_post(api_endpoints.inquiry_v2, request_body)
puts "✅ Result: #{result}"
