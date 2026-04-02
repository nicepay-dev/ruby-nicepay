module NicepayRuby
  # =============================
  # Payout Registration (V2)
  # =============================
  class PayoutRegistrationBuilder
    def initialize
      @request_body = {}
    end

    def set_payout_v2(
    time_stamp:,
      i_mid:,
      merchant_token:,
      account_no:,
      benef_nm:,
      benef_status:,
      benef_type:,
      bank_cd:,
      amt:,
      reference_no:,
      benef_phone:,
      description:,
      payout_method:,
      ms_id: "",
      reserved_dt: "",
      reserved_tm: ""
    )
    @request_body["timeStamp"]      = time_stamp
    @request_body["iMid"]           = i_mid
    @request_body["msId"]           = ms_id
    @request_body["merchantToken"]  = merchant_token
    @request_body["accountNo"]      = account_no
    @request_body["benefNm"]        = benef_nm
    @request_body["benefStatus"]    = benef_status
    @request_body["benefType"]      = benef_type
    @request_body["bankCd"]         = bank_cd
    @request_body["amt"]            = amt
    @request_body["referenceNo"]    = reference_no
    @request_body["reservedDt"]     = reserved_dt
    @request_body["reservedTm"]     = reserved_tm
    @request_body["benefPhone"]     = benef_phone
    @request_body["description"]    = description
    @request_body["payoutMethod"]   = payout_method

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
