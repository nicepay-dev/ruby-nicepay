
  # lib/nicepay_ruby/builder/ewallet_regist.rb
module NicepayRuby
  class EwalletSnapBuilder
    def initialize
      @request_body = {}
    end

    def set_ewallet_v2(
      i_mid:, 
      time_stamp:, 
      pay_method:, 
      currency:, 
      amt:, 
      reference_no:, 
      goods_nm:, 
      merchant_token:,
      bank_cd:,
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
      cart_data:, 
      mitra_cd:
    )
      @request_body["iMid"]          = i_mid
      @request_body["timeStamp"]     = time_stamp
      @request_body["payMethod"]     = pay_method
      @request_body["currency"]      = currency
      @request_body["amt"]           = amt
      @request_body["referenceNo"]   = reference_no
      @request_body["goodsNm"]       = goods_nm
      @request_body["merchantToken"] = merchant_token
      @request_body["bankCd"]        = bank_cd

      # Billing Info
      @request_body["billingNm"]     = billing_nm
      @request_body["billingPhone"]  = billing_phone
      @request_body["billingEmail"]  = billing_email
      @request_body["billingAddr"]   = billing_addr
      @request_body["billingCity"]   = billing_city
      @request_body["billingState"]  = billing_state
      @request_body["billingPostCd"] = billing_post_cd
      @request_body["billingCountry"]= billing_country

      # Delivery Info
      @request_body["deliveryNm"]     = delivery_nm
      @request_body["deliveryPhone"]  = delivery_phone
      @request_body["deliveryAddr"]   = delivery_addr
      @request_body["deliveryCity"]   = delivery_city
      @request_body["deliveryState"]  = delivery_state
      @request_body["deliveryPostCd"] = delivery_post_cd
      @request_body["deliveryCountry"]= delivery_country

      # Other Metadata
      @request_body["dbProcessUrl"]  = db_process_url
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
      @request_body["mitraCd"]       = mitra_cd
       self
    end

  def set_ewallet_payment(
    partner_reference_no:, merchant_id:, sub_merchant_id:, amount_value:, currency:,
    url_param:, external_store_id:, valid_up_to:, point_of_initiation:,
    mitra_cd:, goods_nm:, billing_nm:, billing_phone:, billing_email:,
    call_back_url:, db_process_url:, cart_data:,
    ms_id: "", ms_fee: "", ms_fee_type: "", mb_fee: "", mb_fee_type: ""
  )

    @request_body["partnerReferenceNo"] = partner_reference_no
    @request_body["merchantId"] = merchant_id
    @request_body["subMerchantId"] = sub_merchant_id
    @request_body["amount"] = {
      "value" => amount_value,
      "currency" => currency
    }
    @request_body["urlParam"] = url_param
    @request_body["externalStoreId"] = external_store_id
    @request_body["validUpTo"] = valid_up_to
    @request_body["pointOfInitiation"] = point_of_initiation

    @request_body["additionalInfo"] = {
      "mitraCd" => mitra_cd,
      "goodsNm" => goods_nm,
      "billingNm" => billing_nm,
      "billingPhone" => billing_phone,
      "billingEmail" => billing_email,
      "callBackUrl" => call_back_url,
      "dbProcessUrl" => db_process_url,
      "cartData" => cart_data,
      "msId" => ms_id,
      "msFee" => ms_fee,
      "msFeeType" => ms_fee_type,
      "mbFee" => mb_fee,
      "mbFeeType" => mb_fee_type
    }

    self
  end

  def set_ewallet_inquiry(
    merchant_id:, sub_merchant_id:, original_partner_reference_no:,
    original_reference_no:, service_code:, transaction_date:, external_store_id:,
    amount_value:, currency:
  )
    @request_body["merchantId"] = merchant_id
    @request_body["subMerchantId"] = sub_merchant_id
    @request_body["originalPartnerReferenceNo"] = original_partner_reference_no
    @request_body["originalReferenceNo"] = original_reference_no
    @request_body["serviceCode"] = service_code
    @request_body["transactionDate"] = transaction_date
    @request_body["externalStoreId"] = external_store_id
    @request_body["amount"] = {
      "value" => amount_value,
      "currency" => currency
    }
    @request_body["additionalInfo"] = {}

    self
  end

   def set_ewallet_refund(
    merchant_id:, sub_merchant_id:, original_partner_reference_no:,
    original_reference_no:, partner_refund_no:, refund_amount_value:, currency:,
    external_store_id:, reason:, refund_type:
  )
    @request_body["merchantId"] = merchant_id
    @request_body["subMerchantId"] = sub_merchant_id
    @request_body["originalPartnerReferenceNo"] = original_partner_reference_no
    @request_body["originalReferenceNo"] = original_reference_no
    @request_body["partnerRefundNo"] = partner_refund_no
    @request_body["refundAmount"] = {
      "value" => refund_amount_value,
      "currency" => currency
    }
    @request_body["externalStoreId"] = external_store_id
    @request_body["reason"] = reason
    @request_body["additionalInfo"] = {
      "refundType" => refund_type
    }

    self
  end

  def build
    @request_body
  end
end
end