# frozen_string_literal: true

module NicepayRuby
  module Builder
    module V1
      class Cancel
        attr_accessor :params

        def initialize(params = {})
          @params = params
        end

        def build_merchant_token
          merchant_key = NicepayRuby.configuration.merchant_key
          amt = @params['amt']
          trx_id = @params['tXid']
          raw = "#{amt}#{trx_id}#{merchant_key}"
          NicepayRuby::SignatureGeneratorUtils.encrypt(raw)
        end

        def build_payload
          payload = @params.dup
          payload['merchantToken'] = build_merchant_token
          payload
        end

        def cancel
          endpoint = NicepayRuby::ApiEndpoints.new.cancel_v1
          service_api = NicepayRuby::ServiceApi.new(
            endpoints: nil,
            client_id: nil,
            client_secret: nil,
            channel_id: nil,
            is_production: NicepayRuby.configuration.is_production,
            is_cloud_server: false
          )
          service_api.send_post_form(endpoint, build_payload)
        end
      end
    end
  end
end
