module NicepayRuby
class VirtualAccountBuilder
  def initialize
    @request_body = {}
  end

  # === Versi Virtual Account Merchant (Non-SNAP) ===
  def set_virtual_account(
    i_mid:, time_stamp:, pay_method:, currency:, amt:, reference_no:, goods_nm:, merchant_token:,
    bank_cd:, billing_nm:, billing_phone:, billing_email:, billing_addr:, billing_city:, billing_state:,
    billing_post_cd:, billing_country:, vacct_valid_dt:, vacct_valid_tm:, db_process_url:, mer_fix_acct_id:
  )
    @request_body["timeStamp"]      = time_stamp
    @request_body["iMid"]           = i_mid
    @request_body["payMethod"]      = pay_method
    @request_body["currency"]       = currency
    @request_body["amt"]            = amt
    @request_body["referenceNo"]    = reference_no
    @request_body["goodsNm"]        = goods_nm
    @request_body["merchantToken"]  = merchant_token
    @request_body["bankCd"]         = bank_cd
    @request_body["billingNm"]      = billing_nm
    @request_body["billingPhone"]   = billing_phone
    @request_body["billingEmail"]   = billing_email
    @request_body["billingAddr"]    = billing_addr
    @request_body["billingCity"]    = billing_city
    @request_body["billingState"]   = billing_state
    @request_body["billingPostCd"]  = billing_post_cd
    @request_body["billingCountry"] = billing_country
    @request_body["vacctValidDt"]   = vacct_valid_dt
    @request_body["vacctValidTm"]   = vacct_valid_tm
    @request_body["dbProcessUrl"]   = db_process_url
    @request_body["merFixAcctId"]   = mer_fix_acct_id
    self
  end


  def build
    @request_body
  end
end
end