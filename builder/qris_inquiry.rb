class QrisInquiryBuilder
  def initialize
    @request_body = {}
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

  def build
    @request_body
  end
end
