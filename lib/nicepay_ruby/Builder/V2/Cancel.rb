module NicepayRuby
class CancelBuilder
  def initialize
    @request_body = {}
  end

  def set_cancel_V2(
      time_stamp:,
      t_xid:,
      i_mid:,
      pay_method:,
      cancel_type:,
      cancel_msg:,
      merchant_token:,
      amt:
    )
      @request_body["timeStamp"]     = time_stamp
      @request_body["tXid"]          = t_xid
      @request_body["iMid"]          = i_mid
      @request_body["payMethod"]     = pay_method
      @request_body["cancelType"]    = cancel_type
      @request_body["cancelMsg"]     = cancel_msg
      @request_body["merchantToken"] = merchant_token
      @request_body["amt"]           = amt

      self
    end

  def build
    @request_body
  end
end
end