require_relative 'nicepay_credential'
require 'openssl'
require 'base64'
require 'json'
require 'digest'

class SignatureGeneratorUtils
  def initialize
    @client_id = NicepayCredential.client_id
    @private_key = OpenSSL::PKey::RSA.new(NicepayCredential.private_key)
  end

    def self.generate_string_to_sign(client_id, timestamp)
    "#{client_id}|#{timestamp}"
  end

   # Generate signature for access token (SHA256withRSA)
  def self.generate_signature(private_key_base64, client_id, timestamp)
    string_to_sign = generate_string_to_sign(client_id, timestamp)
    private_key_der = Base64.decode64(private_key_base64)

    rsa = OpenSSL::PKey::RSA.new(private_key_der)
    signature = rsa.sign(OpenSSL::Digest::SHA256.new, string_to_sign)
    Base64.strict_encode64(signature)
  end

  # Generate API signature using HMAC-SHA512
  def self.get_signature(http_method, access_token, request_body, endpoint, timestamp, client_secret)
    json_body = JSON.generate(request_body)
    hashed_body = sha256_encode_hex(json_body)
    endpoint_sign = endpoint.sub(/^nicepay/, '')

    string_to_sign = "#{http_method}:#{endpoint_sign}:#{access_token}:#{hashed_body}:#{timestamp}"
    puts "String to Sign: #{string_to_sign}"

    hmac_sha512_encode_base64(client_secret, string_to_sign)
  end

  
  # HMAC SHA512 encoding (for API signature)
  def self.hmac_sha512_encode_base64(key, data)
    hmac = OpenSSL::HMAC.digest('sha512', key, data)
    Base64.strict_encode64(hmac)
  end

  # SHA256 in hex string
  def self.sha256_encode_hex(data)
    Digest::SHA256.hexdigest(data)
  end

  # Generate random numeric string
  def self.generate_random_number_string(length)
    Array.new(length) { rand(0..9) }.join
  end

  # Optional: SHA256 encrypt utility
  def self.sha256_encrypt(value)
    Digest::SHA256.hexdigest(value)
  end

  # Parse JSON and generate payment URL from response
  def self.generate_payment_url(json_response)
    begin
      json = JSON.parse(json_response)
      txid = json["tXid"]
      payment_url = json["paymentURL"]
      return "#{payment_url}?tXid=#{txid}" if txid && payment_url
    rescue => e
      puts "Error parsing payment URL: #{e.message}"
    end
    nil
  end

  # Optional: Verify signature (public key based)
  def self.verify_sha256_rsa(string_to_sign, public_key_base64, signature_base64)
    begin
      public_key_der = Base64.decode64(public_key_base64)
      public_key = OpenSSL::PKey::RSA.new(public_key_der)
      signature = Base64.decode64(signature_base64)

      is_valid = public_key.verify(OpenSSL::Digest::SHA256.new, signature, string_to_sign)
      puts "Signature is #{is_valid ? 'valid' : 'invalid'}"
      is_valid
    rescue => e
      puts "Error verifying signature: #{e.message}"
      false
    end
  end

  def sha256_hex_minified(json_body)
    minified = JSON.generate(JSON.parse(json_body)) # ensure no spaces, sorted
    Digest::SHA256.hexdigest(minified)
  end

end
