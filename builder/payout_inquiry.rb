class PayoutInquiryBuilder
  def initialize
    @request_body = {}
  end

  def set_payout_inquiry(merchant_id:, original_reference_no:, original_partner_reference_no:,beneficiary_account_no:)
    @request_body = {
      merchantId: merchant_id,
      originalReferenceNo: original_reference_no,
      originalPartnerReferenceNo: original_partner_reference_no,
      beneficiaryAccountNo: beneficiary_account_no
    }
    self
  end

  def build
    @request_body
  end
end
