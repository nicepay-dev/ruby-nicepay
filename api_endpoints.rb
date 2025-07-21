class ApiEndpoints
  attr_reader :create_va, :inquiry_va, :delete_va,
              :payment_ewallet, :status_ewallet, :refund_ewallet,
              :access_token,
              :generate_qris, :status_qris, :refund_qris,
              :create_payout, :approve_payout, :inquiry_payout,
              :cancel_payout, :reject_payout, :balance_payout,
              :regist_v2, :inquiry_v2, :cancel_v2,
              :regist_payout_v2, :inquiry_payout_v2, :reject_payout_v2,
              :approve_payout_v2, :balance_inquiry_v2,
              :regist_redirect_v2

  def initialize
    # VA
    @create_va      = "nicepay/api/v1.0/transfer-va/create-va"
    @inquiry_va     = "nicepay/api/v1.0/transfer-va/status"
    @delete_va      = "nicepay/api/v1.0/transfer-va/delete-va"

    # Ewallet
    @payment_ewallet = "nicepay/api/v1.0/debit/payment-host-to-host"
    @status_ewallet  = "nicepay/api/v1.0/debit/status"
    @refund_ewallet  = "nicepay/api/v1.0/debit/refund"

    # Auth
    @access_token = "nicepay/v1.0/access-token/b2b"

    # QRIS
    @generate_qris = "nicepay/api/v1.0/qr/qr-mpm-generate"
    @status_qris   = "nicepay/api/v1.0/qr/qr-mpm-query"
    @refund_qris   = "nicepay/api/v1.0/qr/qr-mpm-refund"

    # Payout V1
    @create_payout   = "nicepay/api/v1.0/transfer/registration"
    @approve_payout  = "nicepay/api/v1.0/transfer/approve"
    @inquiry_payout  = "nicepay/api/v1.0/transfer/inquiry"
    @cancel_payout   = "nicepay/api/v1.0/transfer/cancel"
    @reject_payout   = "nicepay/api/v1.0/transfer/reject"
    @balance_payout  = "nicepay/api/v1.0/balance-inquiry"

    # Direct V2
    @regist_v2           = "nicepay/direct/v2/registration"
    @inquiry_v2          = "nicepay/direct/v2/inquiry"
    @cancel_v2           = "nicepay/direct/v2/cancel"
    @regist_payout_v2    = "nicepay/api/direct/v2/requestPayout"
    @inquiry_payout_v2   = "nicepay/api/direct/v2/inquiryPayout"
    @reject_payout_v2    = "nicepay/api/direct/v2/rejectPayout"
    @approve_payout_v2   = "nicepay/api/direct/v2/approvePayout"
    @balance_inquiry_v2  = "nicepay/api/direct/v2/balanceInquiry"

    # Redirect
    @regist_redirect_v2  = "nicepay/redirect/v2/registration"
  end
end
