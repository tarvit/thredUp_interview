# Service for generating JWT marker with received 'Payload' data
#
#WARNING:
# Generator using static algorithm – 'HS256' in 'Header'
# Algorithm flexibility could be easily changed when it will be needed

require "#{CONFIG[:lib_path]}/token/validation/helpers"

module Token
  class Generator
    REQUIRED_KEYS = %i{user_id email}.freeze
    HEADER = {typ: 'JWT', alg: 'HS256'}.freeze
    DIGITAL_ALGORITHM = {'HS256' => 'SHA256'}.freeze

    include Validation::Helpers

    attr_reader :payload

    # Receive 'Payload' hash for JWT marker
    def initialize(payload_hash)
      required_keys_exist?(payload_hash)

      @payload = payload_hash
    end

    def generate
      # Encoded 'Header' hash  in base64 format
      encoded_header = Base64.urlsafe_encode64(HEADER.to_json)

      # Encoded 'Payload' hash in base64 format
      encoded_payload = Base64.urlsafe_encode64(payload.to_json)

      # Create prepared 'signature' by concatenated encoded 'Header' with encoded 'Payload' via dot
      prepared_signature = [encoded_header, encoded_payload].join('.')

      # Transfer prepared 'signature' and 'secret_token' to encryption algorithm specified in 'Header' key :alg
      digital_alg = DIGITAL_ALGORITHM[HEADER[:alg]]
      digest = OpenSSL::Digest.new(digital_alg)
      signature = OpenSSL::HMAC.digest(digest, CONFIG[:secret_key], prepared_signature)
      encoded_signature = Base64.urlsafe_encode64(signature)

      # Return concatenated prepared and encoded 'signature' via dot
      [prepared_signature, encoded_signature].join('.')
    end

    private

    def required_keys_exist?(payload_hash)
      received_keys = payload_hash.keys

      REQUIRED_KEYS.each { |key|
        key_missing(key) unless received_keys.include?(key)
      }
    end
  end
end
