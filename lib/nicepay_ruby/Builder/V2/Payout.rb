module NicepayRuby
  # =============================
  # Payout Registration (V2)
  # =============================
  class PayoutRegistrationBuilder
    def initialize
      @request_body = {}
    end

    def set_payout_v2(
      i_mid:,
      time_stamp:,
      pay_method:,
      currency:,
      amt:,
      reference_no:,
      goods_nm:,
      merchant_token:,
      shop_id:,
      billing_nm:,
      billing_phone:,
      billing_email:,
      billing_addr:,
      billing_city:,
      billing_state:,
      billing_post_cd:,
      billing_country:,
      delivery_nm:,
      delivery_phone:,
      delivery_addr:,
      delivery_city:,
      delivery_state:,
      delivery_post_cd:,
      delivery_country:,
      db_process_url:,
      vat:,
      fee:,
      notax_amt:,
      description:,
      req_dt:,
      req_tm:,
      req_domain:,
      req_server_ip:,
      req_client_ver:,
      user_ip:,
      user_session_id:,
      user_agent:,
      user_language:,
      cart_data:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["payMethod"]     = pay_method
      @request_body["currency"]      = currency
      @request_body["amt"]           = amt
      @request_body["referenceNo"]   = reference_no
      @request_body["goodsNm"]       = goods_nm
      @request_body["merchantToken"] = merchant_token
      @request_body["shopId"]        = shop_id
      @request_body["billingNm"]     = billing_nm
      @request_body["billingPhone"]  = billing_phone
      @request_body["billingEmail"]  = billing_email
      @request_body["billingAddr"]   = billing_addr
      @request_body["billingCity"]   = billing_city
      @request_body["billingState"]  = billing_state
      @request_body["billingPostCd"] = billing_post_cd
      @request_body["billingCountry"]= billing_country
      @request_body["dbProcessUrl"]  = db_process_url
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
      @request_body["description"]   = description
      @request_body["reqDt"]         = req_dt
      @request_body["reqTm"]         = req_tm
      @request_body["reqDomain"]     = req_domain
      @request_body["reqServerIP"]   = req_server_ip
      @request_body["reqClientVer"]  = req_client_ver
      @request_body["userIP"]        = user_ip
      @request_body["userSessionID"] = user_session_id
      @request_body["userAgent"]     = user_agent
      @request_body["userLanguage"]  = user_language
      @request_body["cartData"]      = cart_data

      self
    end

    def build
      @request_body
    end
  end

  # =============================
  # Check Balance
  # =============================
  class PayoutCheckBalanceBuilder
    def initialize
      @request_body = {}
    end

    def set_check_balance(
      time_stamp:,
      i_mid:,
      merchant_token:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["merchantToken"] = merchant_token

      self
    end

    def build
      @request_body
    end
  end

  # =============================
  # Approve Payout
  # =============================
  class PayoutApproveBuilder
    def initialize
      @request_body = {}
    end

    def set_approve(
      time_stamp:,
      i_mid:,
      merchant_token:,
      t_xid:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["merchantToken"] = merchant_token
      @request_body["tXid"]          = t_xid

      self
    end

    def build
      @request_body
    end
  end

  # =============================
  # Reject Payout
  # =============================
  class PayoutRejectBuilder
    def initialize
      @request_body = {}
    end

    def set_reject(
      time_stamp:,
      i_mid:,
      merchant_token:,
      t_xid:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["merchantToken"] = merchant_token
      @request_body["tXid"]          = t_xid

      self
    end

    def build
      @request_body
    end
  end

  # =============================
  # Inquiry Payout
  # =============================
  class PayoutInquiryBuilder
    def initialize
      @request_body = {}
    end

    def set_inquiry(
      i_mid:,
      time_stamp:,
      merchant_token:,
      account_no:,
      t_xid:
    )
      @request_body["iMid"]          = i_mid
      @request_body["timeStamp"]     = time_stamp
      @request_body["merchantToken"] = merchant_token
      @request_body["accountNo"]     = account_no
      @request_body["tXid"]          = t_xid

      self
    end

    def build
      @request_body
    end
  end

  # =============================
  # Cancel Payout
  # =============================
  class PayoutCancelBuilder
    def initialize
      @request_body = {}
    end

    def set_cancel(
      time_stamp:,
      i_mid:,
      merchant_token:,
      t_xid:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["iMid"]          = i_mid
      @request_body["merchantToken"] = merchant_token
      @request_body["tXid"]          = t_xid

      self
    end

    def build
      @request_body
    end
  end
end
