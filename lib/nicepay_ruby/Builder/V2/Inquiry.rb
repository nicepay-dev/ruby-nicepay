  module NicepayRuby
  class InquiryBuilder
    def initialize
      @request_body = {}
    end

    def set_check_status(
        i_mid:,
        time_stamp:,
        t_xid:,
        amt:,
        reference_no:,
        merchant_token:
      )
        @request_body["timeStamp"]     = time_stamp
        @request_body["iMid"]          = i_mid
        @request_body["tXid"]          = t_xid
        @request_body["amt"]           = amt
        @request_body["referenceNo"]   = reference_no
        @request_body["merchantToken"] = merchant_token

        self
      end

    def build
      @request_body
    end
  end
end