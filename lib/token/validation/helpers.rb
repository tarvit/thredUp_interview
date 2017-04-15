# Different :helper methods for validation.

module Token
  module Validation
    module Helpers
      # Raise error when required :key missed in received 'Payload' hash
      def key_missing(key)
        raise_error("#{key} is missing in received 'Payload' hash")
      end

      # Raise error when :value for :key doesn't exist or invalid
      def invalid_value(key)
        raise_error("Invalid '#{key}' value entered!")
      end

      # Raise error with specific error class
      def raise_error(message)
        raise(Errors::Token, message)
      end
    end
  end
end
