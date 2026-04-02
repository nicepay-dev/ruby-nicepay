require_relative "../lib/nicepay_ruby"

    string_to_sign = "UNIVYMB002|2026-01-20T09:41:42+07:00"
    public_key_base64 = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1/jkmJGvCP9fWttO7EtVuLw2/rFK9O7bHEgH17yq8vwBFDEr62hIgQIVvD5EE8qeM7L+teB3pFKasGWsNyHX227zt52CzFM8h6rxBkjs1lLroKCEV2nkXBIemXZx59xwDAgfRH3GOXx4RcI0fYfZspIYt/yh+TnSY1oKvbdc65s2OCd8mc6eND8l1xu4mzJovv95nQweIReXf3cNVwmdei0H0ThnZqH8WA2g3kGTJYzoO4WrBQKaWL0VTOOrpA0Zo8Pvd5Io6WVsM8eQinxzhm2vl0rU347pkE2GgBSeFgeqAgC7iYpVEYG2mI/P3yQH0cfuJx6t3FbQZyIJXcPkkwIDAQAB"
    signature_base64 = "qIppgGBeKDYdzn29DmRvke9iSTT91WWb+ld2wxxqTEmEoUEXfLi1UMKxpJ0PkDEoawB9rHJoAzbamoeeikFbCqvJ6PJP3f1I5gewb17JQhmSqYRcT5mmfd+qrgduq2Jnhb/aoJ6/0JUztVorbtt0U77SyOLk10xd5SZKrO0amNE="

    result = NicepayRuby::SignatureGeneratorUtils.verify_sha256_rsa(string_to_sign, public_key_base64, signature_base64)
    puts "Apakah tanda tangan valid? #{result}"
