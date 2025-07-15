class NICEPayBuilder
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

    def get_base_url
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
