# builder/ewallet_payment.rb

class EwalletPaymentBuilder
  def initialize
    @request_body = {}
  end

  def set_ewallet_payment(
    partner_reference_no:, merchant_id:, sub_merchant_id:, amount_value:, currency:,
    url_param:, external_store_id:, valid_up_to:, point_of_initiation:,
    mitra_cd:, goods_nm:, billing_nm:, billing_phone:, billing_email:,
    call_back_url:, db_process_url:, cart_data:,
    ms_id: "", ms_fee: "", ms_fee_type: "", mb_fee: "", mb_fee_type: ""
  )

    @request_body["partnerReferenceNo"] = partner_reference_no
    @request_body["merchantId"] = merchant_id
    @request_body["subMerchantId"] = sub_merchant_id
    @request_body["amount"] = {
      "value" => amount_value,
      "currency" => currency
    }
    @request_body["urlParam"] = url_param
    @request_body["externalStoreId"] = external_store_id
    @request_body["validUpTo"] = valid_up_to
    @request_body["pointOfInitiation"] = point_of_initiation

    @request_body["additionalInfo"] = {
      "mitraCd" => mitra_cd,
      "goodsNm" => goods_nm,
      "billingNm" => billing_nm,
      "billingPhone" => billing_phone,
      "billingEmail" => billing_email,
      "callBackUrl" => call_back_url,
      "dbProcessUrl" => db_process_url,
      "cartData" => cart_data,
      "msId" => ms_id,
      "msFee" => ms_fee,
      "msFeeType" => ms_fee_type,
      "mbFee" => mb_fee,
      "mbFeeType" => mb_fee_type
    }

    self
  end

  def build
    @request_body
  end
end
