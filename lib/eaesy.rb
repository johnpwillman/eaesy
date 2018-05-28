require "eaesy/version"

require 'openssl'
require 'digest/sha2'
require 'base64'

module Eaesy
  class Cipher
    def initialize(key_plain)
      @cipherAlg = "aes-256-cbc"
      @key = sha256(key_plain)
    end

    def encrypt(secret, iv = nil)
      cipher = OpenSSL::Cipher.new(@cipherAlg)
      cipher.encrypt

      # you will need to store this and key for later, in order to decrypt your data
      iv = iv.unpack('m')[0] if iv
      iv = cipher.random_iv unless iv

      # load them into the cipher
      cipher.key = @key
      cipher.iv = iv

      secret = ' ' if (secret || '').length == 0
      # encrypt the message
      encrypted = cipher.update(secret)
      encrypted << cipher.final

      {
        encrypted_secret: [encrypted].pack('m'),
        iv: [iv].pack('m')
      }
    end

    def decrypt(encrypted_secret, iv)
      # now we create a cipher for decrypting
      cipher = OpenSSL::Cipher.new(@cipherAlg)
      cipher.decrypt
      cipher.key = @key
      cipher.iv = iv.unpack('m')[0]

      # and decrypt it
      decrypted = cipher.update(encrypted_secret.unpack('m')[0])
      decrypted << cipher.final

      decrypted
    end

    private

      def sha256(string_to_SHA)
        sha256 = Digest::SHA256.new().digest(string_to_SHA)
      end
  end
end
