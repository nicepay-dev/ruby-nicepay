# lib/nicepay_ruby.rb
require_relative "nicepay_ruby/Utils/configuration"
require_relative "nicepay_ruby/Utils/signatureUtils"
require_relative "nicepay_ruby/Utils/accessToken"
require_relative "nicepay_ruby/Utils/merchantToken"
require_relative "nicepay_ruby/Utils/nicepayConstant"
require_relative "nicepay_ruby/Utils/serviceUtils"
require_relative "builder_file"

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
require_relative "nicepay_ruby/Builder/V2/Redirect"

# V1 Professional
require_relative "nicepay_ruby/Builder/V1/Registration"
require_relative "nicepay_ruby/Builder/V1/Payment"
require_relative "nicepay_ruby/Builder/V1/Inquiry"
require_relative "nicepay_ruby/Builder/V1/Cancel"
require_relative "nicepay_ruby/Builder/V1/VA"
require_relative "nicepay_ruby/Builder/V1/Ewallet"

require_relative "nicepay_ruby/Builder/V1/QRIS"
require_relative "nicepay_ruby/Builder/V1/CVS"
require_relative "nicepay_ruby/Builder/V1/CardToken"


module NicepayRuby
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
