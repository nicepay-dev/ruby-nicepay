module NicepayRuby
class VirtualAccountBuilder
  def initialize
    @request_body = {}
  end

  # === Versi Virtual Account Merchant (Non-SNAP) ===
 
  def set_virtual_account_snap(partner_service_id:, customer_no:, virtual_account_name:, trx_id:, value:, currency:, bank_cd:, goods_nm:, db_process_url:)
    @request_body["partnerServiceId"] = partner_service_id
    @request_body["customerNo"] = customer_no
    @request_body["virtualAccountNo"] = ""
    @request_body["virtualAccountName"] = virtual_account_name
    @request_body["trxId"] = trx_id
    @request_body["totalAmount"] = {
      "value" => value,
      "currency" => currency
    }
    @request_body["additionalInfo"] = {
      "bankCd" => bank_cd,
      "goodsNm" => goods_nm,
      "dbProcessUrl" => db_process_url
    }
    self
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

  def set_virtual_account_cancel(partner_service_id:, customer_no:, virtual_account_no:, trx_id:, value:, currency:, tXid_va:, cancel_message:)
    @request_body["partnerServiceId"] = partner_service_id
    @request_body["customerNo"] = customer_no
    @request_body["virtualAccountNo"] = virtual_account_no
    @request_body["trxId"] = trx_id

    @request_body["additionalInfo"] = {
      "totalAmount" => {
        "value" => value,
        "currency" => currency
      },
      "tXidVA" => tXid_va,
      "cancelMessage" => cancel_message
    }

    self
  end


  def build
    @request_body
  end
end
end