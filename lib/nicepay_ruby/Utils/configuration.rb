module NicepayRuby
  class Configuration
    attr_accessor :client_id, :client_secret, :private_key, :channel_id, :partner_id,
                  :is_production, :is_cloud_server, :merchant_key

    def initialize
      @client_id       = nil
      @client_secret   = nil
      @merchant_key    = nil 
      @private_key     = nil
      @channel_id      = nil
      @partner_id      = nil
      @is_production   = false
      @is_cloud_server = false
    end
  end

  # ⬇️ pindahin ke luar class Configuration
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
