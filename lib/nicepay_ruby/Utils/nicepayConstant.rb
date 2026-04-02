module NicepayRuby
  class Config
    @is_production = false
    @is_cloud_server = false

    class << self
      attr_accessor :is_production, :is_cloud_server

      def get_sandbox_cloud
        "https://dev-services.nicepay.co.id/"
      end

      def get_production_cloud
        "https://services.nicepay.co.id/"
      end

      def get_sandbox_base_url
        "https://dev.nicepay.co.id/"
      end

      def get_production_base_url
        "https://www.nicepay.co.id/"
      end

      def base_url
        if @is_cloud_server
          @is_production ? get_production_cloud : get_sandbox_cloud
        else
          @is_production ? get_production_base_url : get_sandbox_base_url
        end
      end

      def set_environment(production:, cloud_server:)
        @is_production = production
        @is_cloud_server = cloud_server
      end
    end
  end

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
              :regist_redirect_v2,
              :registration_v1, :payment_v1, :inquiry_v1, :cancel_v1,
              :ewallet_regist_v1, :regist_v1, :card_token_v1


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

      # V1 Professional
      @registration_v1 = "nicepay/api/orderRegist.do"
      @payment_v1      = "nicepay/api/onePass.do"
      @inquiry_v1      = "nicepay/api/onePassStatus.do"
      @cancel_v1       = "nicepay/api/onePassAllCancel.do"
      @regist_v1         = "nicepay/api/onePass.do"
      @ewallet_regist_v1 = "nicepay/api/ewalletTrans.do"
      @card_token_v1     = "nicepay/api/onePassToken.do"
    end

    # helper buat gabung base_url + endpoint
    def full_url(path)
      "#{NicepayRuby::Config.base_url}#{path}"
    end

    end
end
