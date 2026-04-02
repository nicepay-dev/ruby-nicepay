# frozen_string_literal: true

require_relative '../../Utils/merchantToken'
require_relative '../../Utils/serviceUtils'
require_relative '../../Utils/nicepayConstant'

module NicepayRuby
  module Builder
    module V1
      class CardToken
        attr_accessor :params

        def initialize(params = {})
          @params = params
        end

        def build_merchant_token
          merchant_key = NicepayRuby.configuration.merchant_key
          NicepayRuby::MerchantTokenGenerate.new.build_v1_merchant_token(
            i_mid: @params['iMid'],
            reference_no: @params['referenceNo'],
            amt: @params['amt'],
            merchant_key: merchant_key
          )
        end

        def build_payload
          payload = @params.dup
          payload['merchantToken'] = build_merchant_token
          payload
        end

        def request_token
          endpoint = NicepayRuby::ApiEndpoints.new.card_token_v1
          service_api = NicepayRuby::ServiceApi.new(
            endpoints: nil,
            client_id: nil,
            client_secret: nil,
            channel_id: nil,
            is_production: NicepayRuby.configuration.is_production,
            is_cloud_server: false
          )
          # Hanya kirim jsonData (stringify) sebagai value form-urlencoded
          body = { 'jsonData' => build_payload.reject { |k, _| k == 'merchantKey' }.to_json }
          service_api.send_post_form(endpoint, body)
        end
      end
    end
  end
end
