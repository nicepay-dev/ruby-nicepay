require_relative "../lib/nicepay_ruby"
require "json"

class SignatureGeneratorUtilsTest
  def self.verif_sign
    string_to_sign = "TNICEVA023|2024-08-19T17:12:40+07:00"
    public_key_base64 = ""
    signature_base64 = "VoxMPjbcV9pro4YyHGQgoRj4rDVJgYk2Ecxn+95B90w47Wnabtco35BfhGpR7a5RukUNnAdeOEBNczSFk4B9uYyu3jc+ceX+Dvz5OYSgSnw5CiMHtGiVnTAqCM/yHZ2MRpIEqekBc4BWMLVtexSWp0YEJjLyo9dZPrSkSbyLVuD7jkUbvmEpVdvK0uK15xb8jueCcDA6LYVXHkq/OMggS1/5mrLNriBhCGLuR7M7hBUJbhpOXSJJEy7XyfItTBA+3MRC2FLcvUpMDrn/wz1uH1+b9A6FP7mG0bRSBOm2BTLyf+xJR5+cdd88RhF70tNQdQxhqr4okVo3IFqlCz2FFg=="

    puts "================================"
    result = SignatureGeneratorUtils.verify_sha256_rsa(string_to_sign, public_key_base64, signature_base64)
    puts "Apakah tanda tangan valid? #{result}"
  end
end

# eksekusi test
SignatureGeneratorUtilsTest.verif_sign
