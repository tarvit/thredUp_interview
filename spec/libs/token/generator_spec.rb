describe Token::Generator do
  let(:payload) {
    {
      user_id: 'test123',
      email: 'test123@test.com'
    }
  }

  context 'initializer' do
    it 'should receive payload hash in constructor' do
      generator = Token::Generator.new(payload)

      expect(generator.payload).to eq(payload)
    end

    it 'should raise error if required payload :key does not received' do
      payload.delete(:email)

      expect {
        Token::Generator.new(payload)
      }.to raise_error("email is missing in received 'Payload' hash")
    end
  end

  context 'generate' do
    let(:encoded_header) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9' }
    let(:encoded_payload) { 'eyJ1c2VyX2lkIjoidGVzdDEyMyIsImVtYWlsIjoidGVzdDEyM0B0ZXN0LmNvbSJ9' }
    let(:encoded_signature) { 'tuQCRCHY7UU_NZEapHVuKe1KakdtFyOqC841bPxRhbQ=' }
    let(:valid_marker) { [encoded_header, encoded_payload, encoded_signature].join('.') }

    it 'should generate valid JWT marker' do
      generator = Token::Generator.new(payload)
      jwt_marker_result = generator.generate

      expect(jwt_marker_result).to eq(valid_marker)
    end
  end
end
