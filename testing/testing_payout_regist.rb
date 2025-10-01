require_relative "../lib/nicepay_ruby"
require 'json'

# def initialize
#     @client_id = NicepayCredential.client_id
#     @signature_generator = SignatureGeneratorUtils.new
#   end
# === CONFIGURATION ===
NicepayRuby.configure do |config|
  config.client_id     = "NORMALTEST"
  config.private_key   = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAInJe1G22R2fMchIE6BjtYRqyMj6lurP/zq6vy79WaiGKt0Fxs4q3Ab4ifmOXd97ynS5f0JRfIqakXDcV/e2rx9bFdsS2HORY7o5At7D5E3tkyNM9smI/7dk8d3O0fyeZyrmPMySghzgkR3oMEDW1TCD5q63Hh/oq0LKZ/4Jjcb9AgMBAAECgYA4Boz2NPsjaE+9uFECrohoR2NNFVe4Msr8/mIuoSWLuMJFDMxBmHvO+dBggNr6vEMeIy7zsF6LnT32PiImv0mFRY5fRD5iLAAlIdh8ux9NXDIHgyera/PW4nyMaz2uC67MRm7uhCTKfDAJK7LXqrNVDlIBFdweH5uzmrPBn77foQJBAMPCnCzR9vIfqbk7gQaA0hVnXL3qBQPMmHaeIk0BMAfXTVq37PUfryo+80XXgEP1mN/e7f10GDUPFiVw6Wfwz38CQQC0L+xoxraftGnwFcVN1cK/MwqGS+DYNXnddo7Hu3+RShUjCz5E5NzVWH5yHu0E0Zt3sdYD2t7u7HSr9wn96OeDAkEApzB6eb0JD1kDd3PeilNTGXyhtIE9rzT5sbT0zpeJEelL44LaGa/pxkblNm0K2v/ShMC8uY6Bbi9oVqnMbj04uQJAJDIgTmfkla5bPZRR/zG6nkf1jEa/0w7i/R7szaiXlqsIFfMTPimvRtgxBmG6ASbOETxTHpEgCWTMhyLoCe54WwJATmPDSXk4APUQNvX5rr5OSfGWEOo67cKBvp5Wst+tpvc6AbIJeiRFlKF4fXYTb6HtiuulgwQNePuvlzlt2Q8hqQ=="
  config.client_secret = "1af9014925cab04606b2e77a7536cb0d5c51353924a966e503953e010234108a"
  config.channel_id    = "123456"
  config.partner_id    = "NORMALTEST"
  config.is_production = false
  config.is_cloud_server = false
end

client_id     = NicepayRuby.configuration.client_id
client_secret = NicepayRuby.configuration.client_secret
private_key   = NicepayRuby.configuration.private_key
channel_id    = NicepayRuby.configuration.channel_id
is_production = NicepayRuby.configuration.is_production
is_cloud = NicepayRuby.configuration.is_cloud_server

timestamp   = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
external_id = NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(8)
trx_id      = "trxId" + NicepayRuby::SignatureGeneratorUtils.generate_random_number_string(6)


# === STEP 1: Generate Signature ===
signature = NicepayRuby::SignatureGeneratorUtils.generate_signature(private_key, client_id, timestamp)

# === STEP 2: Get Access Token ===
client = NicepayRuby::AccessTokenClient.new
result = client.request_access_token
access_token = result["accessToken"]


# STEP 3: Build Request Body
builder = NicepayRuby::PayoutSnapBuilder.new
request_body = builder.set_payout_snap(
  merchant_id: "NORMALTEST",
  ms_id: "",
  beneficiary_account_no: "5345000060",
  beneficiary_name: "IONPAY NETWORKS",
  beneficiary_phone: "08123456789",
  beneficiary_residence: "1",
  beneficiary_type: "1",
  beneficiary_postal_code: "123456",
  payout_method: "0",
  beneficiary_bank_code: "CENA",
  amount_value: "12345678.00",
  partner_reference_no: trx_id,
  description: "This is test Request",
  reserved_dt: Time.now.strftime('%Y%m%d'),
  reserved_tm: Time.now.strftime('%H%M%S')
).build

# STEP 4: Hit API
endpoints = NicepayRuby::ApiEndpoints.new
service = NicepayRuby::ServiceApi.new(
  client_id: client_id,
  client_secret: client_secret,
  channel_id: channel_id,
  is_production: is_production,
  is_cloud_server: is_cloud
)

response = service.send_post_request(endpoints.create_payout, access_token, timestamp, request_body, external_id)

puts "[REQUEST BODY] #{JSON.pretty_generate(request_body)}"
puts "[RESPONSE] #{response}"
