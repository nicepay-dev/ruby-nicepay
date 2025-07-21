# builder/qris_registration.rb

class QrisRegistrationBuilder
  def initialize
    @request_body = {}
  end

  def set_qris_registration(
    partner_reference_no:, amount_value:, currency:, merchant_id:,
    store_id:, validity_period:, additional_info:
  )
    @request_body["partnerReferenceNo"] = partner_reference_no
    @request_body["amount"] = {
      "value" => amount_value,
      "currency" => currency
    }
    @request_body["merchantId"] = merchant_id
    @request_body["storeId"] = store_id
    @request_body["validityPeriod"] = validity_period
    @request_body["additionalInfo"] = additional_info

    self
  end

  def build
    @request_body
  end
end
