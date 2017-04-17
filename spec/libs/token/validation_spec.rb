describe Token::Validation do
  let(:dummy) { Class.new { extend Token::Validation } }

  context 'validate required' do
    context ':user_id' do
      let(:format) { Token::Validation::USER_ID_FORMAT }

      it 'should pass validation with correct :user_id value' do
        user_id = dummy.validate_required(:user_id, 'test123', format: format)

        expect(user_id).to be_nil
      end

      it 'should raise error for blank :user_id value' do
        expect {
          dummy.validate_required(:user_id, '', format: format)
        }.to raise_error(Errors::Token, "Invalid 'user_id' value entered!")
      end

      it 'should raise error for incorrect :user_id format' do
        expect {
          dummy.validate_required(:user_id, 'test@123', format: format)
        }.to raise_error(Errors::Token, "Invalid 'user_id' value entered!")
      end
    end

    context ':email' do
      let(:format) { Token::Validation::EMAIL_FORMAT }

      it 'should pass validation with correct :email value' do
        email = dummy.validate_required(:email, 'test123@test.com', format: format)

        expect(email).to be_nil
      end

      it 'should raise error for blank :email value' do
        expect {
          dummy.validate_required(:email, '', format: format)
        }.to raise_error(Errors::Token, "Invalid 'email' value entered!")
      end

      it 'should raise error for incorrect :email format' do
        expect {
          dummy.validate_required(:email, 'test123-test.com', format: format)
        }.to raise_error(Errors::Token, "Invalid 'email' value entered!")
      end
    end
  end

  context 'validate additional' do
    context 'additional :key' do
      let(:format) { Token::Validation::ADDITIONAL_KEY_FORMAT }

      it 'should pass validation with correct additional :key value' do
        additional_key = dummy.validate_additional('test123', 'test123')

        expect(additional_key).to be_nil
      end

      it 'should raise error for blank additional :key value' do
        expect {
          dummy.validate_additional('', 'test123')
        }.to raise_error(Errors::Token, "Invalid 'additional key' value entered!")
      end

      it 'should raise error for incorrect additional :key format' do
        expect {
          dummy.validate_additional('test-123', 'test123')
        }.to raise_error(Errors::Token, "Invalid 'additional key' value entered!")
      end
    end

    context 'additional :value' do
      it 'should pass validation with correct additional :value value' do
        additional_value = dummy.validate_additional('test123', 'test123')

        expect(additional_value).to be_nil
      end

      it 'should raise error for blank additional :value value' do
        expect {
          dummy.validate_additional('test123', '')
        }.to raise_error(Errors::Token, "Invalid 'additional value' value entered!")
      end
    end
  end
end
