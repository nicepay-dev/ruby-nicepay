class PayoutBalanceBuilder
  def initialize
    @request_body = {}
  end

  def set_payout_balance(account_no:, ms_id: "")
    @request_body = {
      accountNo: account_no,
      additionalInfo: {
        msId: ms_id
      }
    }
    self
  end

  def build
    @request_body
  end
end
