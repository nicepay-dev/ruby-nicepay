class QrisRefundBuilder
  def initialize
    @request_body = {}
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
