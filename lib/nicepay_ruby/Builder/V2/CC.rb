module NicepayRuby
class CCRegistrationBuilder
  def initialize
    @request_body = {}
  end

  def set_cc_regist(
    i_mid:,
    time_stamp:,
    pay_method:,
    currency:,
    amt:,
    reference_no:,
    description:,
    goods_nm:,
    merchant_token:,
    billing_nm:,
    billing_phone:,
    billing_email:,
    billing_addr:,
    billing_city:,
    billing_state:,
    billing_country:,
    billing_post_cd:,
    db_process_url:,
    call_back_url:,
    cart_data:,
    user_ip:,
    instmnt_type:,
    instmnt_mon:,
    recurr_opt:,
    user_language:,
    user_agent:
  )
    @request_body["timeStamp"]     = time_stamp
    @request_body["iMid"]          = i_mid
    @request_body["payMethod"]     = pay_method
    @request_body["currency"]      = currency
    @request_body["amt"]           = amt
    @request_body["referenceNo"]   = reference_no
    @request_body["description"]   = description
    @request_body["goodsNm"]       = goods_nm
    @request_body["merchantToken"] = merchant_token
    @request_body["billingNm"]     = billing_nm
    @request_body["billingPhone"]  = billing_phone
    @request_body["billingEmail"]  = billing_email
    @request_body["billingAddr"]   = billing_addr
    @request_body["billingCity"]   = billing_city
    @request_body["billingState"]  = billing_state
    @request_body["billingCountry"]= billing_country
    @request_body["billingPostCd"] = billing_post_cd
    @request_body["dbProcessUrl"]  = db_process_url
    @request_body["callBackUrl"]   = call_back_url
    @request_body["cartData"]      = cart_data
    @request_body["userIP"]        = user_ip
    @request_body["instmntType"]   = instmnt_type
    @request_body["instmntMon"]    = instmnt_mon
    @request_body["recurrOpt"]     = recurr_opt
    @request_body["userLanguage"]  = user_language
    @request_body["userAgent"]     = user_agent

    self
  end

  def build
    @request_body
  end
end
end