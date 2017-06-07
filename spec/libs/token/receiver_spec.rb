describe Token::Receiver do
  before(:each) do
    allow(Token::Receiver).to receive(:get_value).and_return(cli_value)
  end

  context 'required pairs' do
    context ':user_id' do
      let(:cli_value) { 'test123' }

      it 'should receive :user_id value and return key/value pair' do
        user_id_pair = Token::Receiver.get_required_pair(:user_id)

        expect(user_id_pair).to be_a(Hash)
        expect(user_id_pair.keys[0]).to eq(:user_id)
        expect(user_id_pair.values[0]).to eq(cli_value)
      end
    end

    context ':email' do
      let(:cli_value) { 'test123@test.com' }

      it 'should receive :user_id value and return key/value pair' do
        email_pair = Token::Receiver.get_required_pair(:email)

        expect(email_pair).to be_a(Hash)
        expect(email_pair.keys[0]).to eq(:email)
        expect(email_pair.values[0]).to eq(cli_value)
      end
    end
  end

  context 'additional pairs' do
    let(:cli_value) { 'test123' }

    it 'should receive additional key and value and return key/value pair' do
      allow(Token::Receiver).to receive(:get_value).and_return(cli_value)

      additional_pair = Token::Receiver.get_additional_pair

      expect(additional_pair).to be_a(Hash)
      expect(additional_pair.keys[0]).to eq(cli_value.to_sym)
      expect(additional_pair.values[0]).to eq(cli_value)
    end
  end
end
