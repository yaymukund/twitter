def random_string(length=16)
  require 'securerandom'
  SecureRandom.hex(length)
end
