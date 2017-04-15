require_relative 'config/application'

puts 'Starting JWT payload receiving'
generated_hash = {}

generated_hash.update(Token::Receiver.get_required_pair(:user_id))
generated_hash.update(Token::Receiver.get_required_pair(:email))

loop {
  puts 'Any additional inputs? (yes/no)'
  # Remove any special characters and downcase received string to prevent errors
  answer = gets.strip.downcase
  break unless answer == 'yes'

  generated_hash.update(Token::Receiver.get_additional_pair)
}

puts 'Starting JWT generation'
jwt_token = Token::Generator.new(generated_hash).generate

# Copy generated JWT marker 'String' to clipboard
IO.popen('pbcopy', 'w') { |pipe| pipe << jwt_token }

puts 'The JWT has been generated and copied to your clipboard!'
