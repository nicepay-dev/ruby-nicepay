# builder/virtual_account_cancel.rb

class VirtualAccountCancelBuilder
  def initialize
    @request_body = {}
  end

  def set_virtual_account_cancel(partner_service_id:, customer_no:, virtual_account_no:, trx_id:, value:, currency:, tXid_va:, cancel_message:)
    @request_body["partnerServiceId"] = partner_service_id
    @request_body["customerNo"] = customer_no
    @request_body["virtualAccountNo"] = virtual_account_no
    @request_body["trxId"] = trx_id

    @request_body["additionalInfo"] = {
      "totalAmount" => {
        "value" => value,
        "currency" => currency
      },
      "tXidVA" => tXid_va,
      "cancelMessage" => cancel_message
    }

    self
  end

  def build
    @request_body
  end
end
