# Validation for JWT marker 'Payload'

%w{helpers predicates}.each { |path|
  require "#{CONFIG[:lib_path]}/token/validation/#{path}"
}

module Token
  module Validation
    # Regex for check valid format for different values
    USER_ID_FORMAT = /^[a-z0-9]*$+/.freeze
    EMAIL_FORMAT = /^[a-z0-9].+@.+\..+/.freeze
    ADDITIONAL_KEY_FORMAT = /^[a-z0-9]*_?[a-z0-9]+$/.freeze

    include Helpers
    include Predicates

    # Validate received 'key/value' pair in different way
    def validate_pair(key, value)
      case key
        when :user_id
          # Value for 'user_id' is required and should have valid format
          validate_required(:user_id, value, format: USER_ID_FORMAT)
        when :email
          # Value for 'email' is required and should have valid format
          validate_required(:email, value, format: EMAIL_FORMAT)
        else
          validate_additional(key, value)
      end
    end

    # Validation for required 'key/value' pair
    def validate_required(key, value, **options)
      result = value_present?(value)
      result &= valid_format?(value, options[:format]) if options[:format].present?

      invalid_value(key) unless result
    end

    # Validation for additional 'key/value' pair
    def validate_additional(key, value)
      # Value for 'additional key' should present and have valid format
      key_condition = value_present?(key) && valid_format?(key, ADDITIONAL_KEY_FORMAT)
      invalid_value('additional key') unless key_condition

      # Value for 'additional value' should present
      value_condition = value_present?(value)
      invalid_value('additional value') unless value_condition
    end
  end
end
