# builder/qris_registration.rb

class QrisSnapBuilder
  def initialize
    @request_body = {}
  end

    
  def set_qris_snap(
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

  def set_qris_inquiry(
    original_reference_no:,
    original_partner_reference_no:,
    merchant_id:,
    external_store_id:,
    service_code:,
    additional_info: {}
  )
    @request_body = {
      originalReferenceNo: original_reference_no,
      originalPartnerReferenceNo: original_partner_reference_no,
      merchantId: merchant_id,
      externalStoreId: external_store_id,
      serviceCode: service_code,
      additionalInfo: additional_info
    }
    self
  end

  def set_qris_refund(
    original_reference_no:,
    original_partner_reference_no:,
    partner_refund_no:,
    merchant_id:,
    external_store_id:,
    refund_value:,
    currency: "IDR",
    reason:,
    additional_info: {}
  )
    @request_body = {
      originalReferenceNo: original_reference_no,
      originalPartnerReferenceNo: original_partner_reference_no,
      partnerRefundNo: partner_refund_no,
      merchantId: merchant_id,
      externalStoreId: external_store_id,
      refundAmount: {
        value: refund_value,
        currency: currency
      },
      reason: reason,
      additionalInfo: additional_info
    }
    self
  end

  def build
    @request_body
  end
end
