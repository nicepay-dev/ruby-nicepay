Gem::Specification.new do |spec|
  spec.name          = "nicepay_ruby"
  spec.version       = "1.1.0"
  spec.authors       = ["NICEPay_Integration"]
  spec.email         = ["nicepayintegration@gmail.com"]

  spec.summary       = "Nicepay plugin ruby"
  spec.description   = "Nicepay plugin for Ruby to access merchant consume API SNAP and Non-SNAP from Nicepay"
  spec.homepage      = "https://github.com/nicepay-dev/ruby-nicepay.git"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.4.4"

  spec.files         = Dir["lib/**/*.rb", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
end
