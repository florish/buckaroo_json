require 'buckaroo_json/authorization_header'

describe BuckarooJson::AuthorizationHeader do
  describe '.create' do
    let(:result) do
      described_class.create(
        website_key: 'foo',
        api_key: 'bar',
        method: 'GET',
        url: 'https://example.com/json/someEndpoint?someParam=someValue'
      )
    end

    it 'returns a well-formatted header value' do
      expect(result).to match(
        %r{\Ahmac foo:[[:alnum:]/+]+=:\h+:\d{10}\z}
      )
    end

    it 'returns expected string for predefined timestamp and nonce' do
      allow(described_class).to receive_messages(
        current_timestamp: 1_447_619_979,
        current_nonce: '7bdb2ecc631c584b0ce10fd1b505df84'
      )
      expect(result).to eq(
        'hmac foo:g/mqa1gXAfqxvKvBDE5UCDXxJY8saQmoaeo1mwh/eIk=:7bdb2ecc631c584b0ce10fd1b505df84:1447619979'
      )
    end
  end
end
