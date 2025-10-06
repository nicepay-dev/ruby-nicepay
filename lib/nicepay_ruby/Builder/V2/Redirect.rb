module NicepayRuby
  class RedirectRegistrationBuilder
    def initialize
      @request_body = {}
    end

    def set_regist_redirect_v2(
      time_stamp:,
      i_mid:,
      pay_method:,
      bank_cd:,
      currency:,
      amt:,
      reference_no:,
      merchant_token:,
      call_back_url:,
      db_process_url:,
      goods_nm:,
      mitra_cd:,
      vacct_valid_dt:,
      vacct_valid_tm:,
      description:,
      billing_nm:,
      billing_phone:,
      billing_email:,
      billing_addr:,
      billing_city:,
      billing_state:,
      billing_post_cd:,
      billing_country:,
      user_ip:,
      cart_data:,
      delivery_nm:,
      delivery_phone:,
      delivery_addr:,
      delivery_city:,
      delivery_state:,
      delivery_post_cd:,
      delivery_country:,
      vat: "",
      fee: "",
      notax_amt: "",
      req_dt: "",
      req_tm: "",
      req_domain: "",
      req_server_ip: "",
      req_client_ver: "",
      user_session_id: "",
      user_agent: "",
      user_language: "",
      instmnt_type: "",
      instmnt_mon:"",
      recurr_opt:"",
      payment_exp_dt: "",
      payment_exp_tm:"",
      shop_id: "",
      pay_valid_dt: "",
      pay_valid_tm: "",
      mer_fix_acct_id:""
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["payMethod"]     = pay_method
      @request_body["bankCd"]        = bank_cd
      @request_body["currency"]      = currency
      @request_body["amt"]           = amt
      @request_body["referenceNo"]   = reference_no
      @request_body["merchantToken"] = merchant_token
      @request_body["callBackUrl"]   = call_back_url
      @request_body["dbProcessUrl"]  = db_process_url
      @request_body["goodsNm"]       = goods_nm
      @request_body["mitraCd"]       = mitra_cd
      @request_body["vacctValidDt"]  = vacct_valid_dt
      @request_body["vacctValidTm"]  = vacct_valid_tm
      @request_body["description"]   = description
      @request_body["billingNm"]     = billing_nm
      @request_body["billingPhone"]  = billing_phone
      @request_body["billingEmail"]  = billing_email
      @request_body["billingAddr"]   = billing_addr
      @request_body["billingCity"]   = billing_city
      @request_body["billingState"]  = billing_state
      @request_body["billingPostCd"] = billing_post_cd
      @request_body["billingCountry"]= billing_country
      @request_body["userIP"]        = user_ip
      @request_body["cartData"]      = cart_data
      @request_body["deliveryNm"]    = delivery_nm
      @request_body["deliveryPhone"] = delivery_phone
      @request_body["deliveryAddr"]  = delivery_addr
      @request_body["deliveryCity"]  = delivery_city
      @request_body["deliveryState"] = delivery_state
      @request_body["deliveryPostCd"]= delivery_post_cd
      @request_body["deliveryCountry"]= delivery_country
      @request_body["vat"]           = vat
      @request_body["fee"]           = fee
      @request_body["notaxAmt"]      = notax_amt
      @request_body["reqDt"]         = req_dt
      @request_body["reqTm"]         = req_tm
      @request_body["reqDomain"]     = req_domain
      @request_body["reqServerIP"]   = req_server_ip
      @request_body["reqClientVer"]  = req_client_ver
      @request_body["userSessionID"] = user_session_id
      @request_body["userAgent"]     = user_agent
      @request_body["userLanguage"]  = user_language
      @request_body["instmntType"]   = instmnt_type
      @request_body["instmntMon"]    = instmnt_mon
      @request_body["recurrOpt"]     = recurr_opt
      @request_body["paymentExpDt"] = payment_exp_dt
      @request_body["paymentExpTm"]     = payment_exp_tm
      @request_body["shopId"]  = shop_id
      @request_body["payValidDt"] = pay_valid_dt
      @request_body["payValidTm"]     = pay_valid_tm
      @request_body["merFixAcctId"]  = mer_fix_acct_id

      self
    end

    def build
      @request_body
    end
  end
end
