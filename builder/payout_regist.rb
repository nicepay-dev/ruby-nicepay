class PayoutRegistrationBuilder
  def initialize
    @request_body = {}
  end

  def set_payout_registration(
    merchant_id:,
    ms_id: "",
    beneficiary_account_no:,
    beneficiary_name:,
    beneficiary_phone:,
    beneficiary_residence:,
    beneficiary_type:,
    beneficiary_postal_code:,
    payout_method:,
    beneficiary_bank_code:,
    amount_value:,
    currency: "IDR",
    partner_reference_no:,
    description:,
    reserved_dt:,
    reserved_tm:
  )
    @request_body = {
      merchantId: merchant_id,
      msId: ms_id,
      beneficiaryAccountNo: beneficiary_account_no,
      beneficiaryName: beneficiary_name,
      beneficiaryPhone: beneficiary_phone,
      beneficiaryCustomerResidence: beneficiary_residence,
      beneficiaryCustomerType: beneficiary_type,
      beneficiaryPostalCode: beneficiary_postal_code,
      payoutMethod: payout_method,
      beneficiaryBankCode: beneficiary_bank_code,
      amount: {
        value: amount_value,
        currency: currency
      },
      partnerReferenceNo: partner_reference_no,
      description: description,
      reservedDt: reserved_dt,
      reservedTm: reserved_tm
    }
    self
  end

  def build
    @request_body
  end
end
