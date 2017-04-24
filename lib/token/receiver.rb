# Service for receiving keys and their values for JWT marker 'Payload'

require "#{CONFIG[:lib_path]}/token/validation"

module Token
  class Receiver
    class << self
      include Token::Validation

      # Receive, validate and return required 'key/value' pair in 'Hash' format from 'CLI'
      # Number of tries - 3
      def get_required_pair(key)
        key = key.to_sym
        tries = 3

        begin
          value = get_value(key)

          validate_pair(key, value)
          {key => value}
        rescue Errors::Token => e
          puts e.message
          tries -= 1

          if tries > 0
            puts "#{tries} tries left!"
            retry
          else
            puts 'JWT payload receiving was failed! Try again!'
            exit
          end
        end
      end

      # Receive, validate and return additional 'key/value' pair in 'Hash' format from 'CLI'
      # Number of tries - 1
      def get_additional_pair
        begin
          key = get_value('additional key').downcase.to_sym
          value = get_value('additional value')

          validate_pair(key, value)
          {key => value}
        rescue Errors::Token => e
          puts e.message
        end
      end

      # Receive :value for :key from 'CLI'
      # Remove any special characters from received string
      def get_value(key)
        puts "Enter '#{key}' value"
        gets.strip
      end
    end
  end
end
