require_relative "../lib/nicepay_ruby"
require "json"

# ✅ Build payload
NicepayRuby.configure do |config|
  config.client_id       = "SITGLOBAL2"  
  config.merchant_key    = "EYZHK3MuvglWLFAf9QAd6vQDexAxdaBhPrQ+tbygcpOPDoJtgmJ1OGUtuVyXqmitxkybhKwLo5NFXqxNtLFkYA=="  
  config.is_production = false
  config.is_cloud_server = false
end

client_id    = NicepayRuby.configuration.client_id
merchant_key = NicepayRuby.configuration.merchant_key

# === COMMON DATA ===
amount      = "11000"
reference_no = "REF" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(8)
timestamp    = Time.now.strftime("%Y%m%d%H%M%S")
account_no =  "6018991111"

token_builder = NicepayRuby::MerchantTokenGenerate.new
  .set_time_stamp(timestamp)
  .set_imid(client_id)
  .set_ref_no(reference_no)
  .set_amount(amount)
  .set_merchant_key(merchant_key)
  .set_account_no(account_no)

merchant_token = token_builder.build_payout_merchant_token
# === STEP 2: Build Body ===
builder = NicepayRuby::PayoutRegistrationBuilder.new
request_body = builder.set_payout_v2(
 time_stamp: timestamp,
  i_mid: client_id,
  ms_id: "",
  merchant_token: merchant_token,
  account_no: "6018991111",
  benef_nm: "PT IONPAY NETWORKS",
  benef_status: "1",
  benef_type: "1",
  bank_cd: "MASD",
  amt: amount,
  reference_no: reference_no,
  benef_phone: "082111111111",
  description: "This is test request",
  payout_method: "1"

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
result = service.send_post(api_endpoints.regist_payout_v2, request_body)
puts "✅ Result: #{result}"
