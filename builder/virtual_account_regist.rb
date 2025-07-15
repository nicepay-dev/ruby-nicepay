class VirtualAccountBuilder
  def initialize
    @request_body = {}
  end

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

  def build
    @request_body
  end
end
