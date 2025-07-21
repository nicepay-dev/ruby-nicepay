# builder/ewallet_refund.rb

class EwalletRefundBuilder
  def initialize
    @request_body = {}
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
