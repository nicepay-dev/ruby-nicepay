# builder/ewallet_inquiry.rb

class EwalletInquiryBuilder
  def initialize
    @request_body = {}
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

  def build
    @request_body
  end
end
