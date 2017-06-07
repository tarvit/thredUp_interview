# Predicate methods for checking different validation :options.

module Token
  module Validation
    module Predicates
      # Check is :value present
      def value_present?(value)
        value.present?
      end

      # Check is :value has correct format
      def valid_format?(value, format_regex)
        !!(value =~ format_regex)
      end
    end
  end
end
