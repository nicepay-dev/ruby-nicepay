# builder/virtual_account_inquiry.rb

class VirtualAccountInquiryBuilder
  def initialize
    @request_body = {}
  end

   def set_virtual_account_inquiry(partner_service_id:, customer_no:, virtual_account_no:, inquiry_request_id:, trx_id:, tXid_va:, value:, currency:)
    @request_body["partnerServiceId"] = partner_service_id
    @request_body["customerNo"] = customer_no
    @request_body["virtualAccountNo"] = virtual_account_no
    @request_body["inquiryRequestId"] = inquiry_request_id

    @request_body["additionalInfo"] = {
      "totalAmount" => {
        "value" => value,
        "currency" => currency
      },
      "trxId" => trx_id,
      "tXidVA" => tXid_va
    }
    self
  end

  def build
    @request_body
  end
end
