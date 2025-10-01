# lib/nicepay_ruby.rb
require_relative "nicepay_ruby/Utils/configuration"
require_relative "nicepay_ruby/Utils/signatureUtils"
require_relative "nicepay_ruby/Utils/accessToken"
require_relative "nicepay_ruby/Utils/merchantToken"
require_relative "nicepay_ruby/Utils/nicepayConstant"
require_relative "nicepay_ruby/Utils/serviceUtils"
require_relative "nicepay_ruby/builder"

require_relative "nicepay_ruby/Builder/SNAP/VA"
require_relative "nicepay_ruby/Builder/SNAP/Ewallet"
require_relative "nicepay_ruby/Builder/SNAP/QRIS"
require_relative "nicepay_ruby/Builder/SNAP/Payout"

require_relative "nicepay_ruby/Builder/V2/VA"
require_relative "nicepay_ruby/Builder/V2/Ewallet"
require_relative "nicepay_ruby/Builder/V2/QRIS"
require_relative "nicepay_ruby/Builder/V2/Payout"
require_relative "nicepay_ruby/Builder/V2/CC"
require_relative "nicepay_ruby/Builder/V2/Inquiry"
require_relative "nicepay_ruby/Builder/V2/Cancel"


module NicepayRuby
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
