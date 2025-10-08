# lib/nicepay_ruby/merchant_token_builder.rb
require_relative 'signatureUtils'
require_relative 'nicepayConstant'


module NicepayRuby
  class MerchantTokenGenerate
    def initialize
      @time_stamp = nil
      @i_mid = nil
      @ref_no = nil
      @amount = nil
      @merchant_key = nil
      @account_no = nil
      @txid = nil
    end

    def set_time_stamp(time_stamp); @time_stamp = time_stamp; self; end
    def set_account_no(account_no); @account_no = account_no; self; end
    def set_imid(i_mid); @i_mid = i_mid; self; end
    def set_ref_no(ref_no); @ref_no = ref_no; self; end
    def set_amount(amount); @amount = amount; self; end
    def set_txid(txid); @txid = txid; self; end
    def set_merchant_key(merchant_key); @merchant_key = merchant_key; self; end

    # --- Build Tokens ---
    def build_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@ref_no}#{@amount}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end

    def build_payout_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@amount}#{@account_no}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end

    def build_payout_status_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@txid}#{@account_no}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end

    def build_payout_step_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@txid}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end

    def build_payout_balance_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end

    def build_cancel_merchant_token
      raw = "#{@time_stamp}#{@i_mid}#{@txid}#{@amount}#{@merchant_key}"
      NicepayRuby::SignatureGeneratorUtils.encrypt(raw)

    end
  end
end
