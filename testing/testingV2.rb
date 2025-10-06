require_relative "../lib/nicepay_ruby"
require "json"

# ✅ Build payload
NicepayRuby.configure do |config|
  config.client_id       = ""  
  config.merchant_key    = ""  
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
builderCC = NicepayRuby::RedirectRegistrationBuilder.new
request_body = builderCC.set_regist_redirect_v2(
 time_stamp: timestamp,
  i_mid: client_id,
  pay_method: "02", # VA
  bank_cd: "",
  currency: "IDR",
  amt: amount,
  reference_no: reference_no,
  merchant_token: merchant_token,
  call_back_url: "https://webhook.site/xxx",
  db_process_url: "https://webhook.site/xxx",
  goods_nm: "Goods",
  mitra_cd: "",
  vacct_valid_dt: "20231130",
  vacct_valid_tm: "235959",
  description: "Testing API by Sibedul",
  billing_nm: "Hantu Kesorean",
  billing_phone: "081288998899",
  billing_email: "abdul@example.com",
  billing_addr: "Jln. Raya Kasablanka Kav.88",
  billing_city: "South Jakarta",
  billing_state: "DKI Jakarta",
  billing_post_cd: "12800",
  billing_country: "Indonesia",
  user_ip: "127.0.0.1",
  cart_data: {
    count: "1",
    item: [
      {
        goods_id: "BB12345678",
        goods_detail: "BB123456",
        goods_name: "iPhone5S",
        goods_amt: amount,
        goods_type: "Smartphone",
        goods_url: "http://merchant.com/cellphones/iphone5s_64g",
        goods_quantity: "1",
        goods_sellers_id: "SEL123",
        goods_sellers_name: "Sellers1"
      }
    ]
  }.to_json,
  delivery_nm: "Hantu Kesorean",
  delivery_phone: "081288998899",
  delivery_addr: "Jln. Raya Kasablanka Kav.88",
  delivery_city: "South Jakarta",
  delivery_state: "DKI Jakarta",
  delivery_post_cd: "12800",
  delivery_country: "Indonesia",
  instmnt_type: "",
  instmnt_mon: "",
  recurr_opt: "",
  payment_exp_dt:"",
  payment_exp_tm:"",
  shop_id:""

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
result = service.send_post(api_endpoints.regist_redirect_v2, request_body)
puts "✅ Result: #{result}"
