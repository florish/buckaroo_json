require 'buckaroo_json/request'
require 'webmock/rspec'

describe BuckarooJson::Request do
  describe '.create' do
    let(:input) do
      {
        mode: 'test',
        website_key: 'foo',
        api_key: 'bar',
        method: 'POST',
        endpoint: 'EndPoint',
        content: { 'a' => 1 }
      }
    end
    it 'converts body content to JSON' do
      stub_request(:post, 'https://testcheckout.buckaroo.nl/json/EndPoint')
      subject.create(**input)
      expect(WebMock).to have_requested(
        :post,
        'https://testcheckout.buckaroo.nl/json/EndPoint'
      ).with { |req|
        req.body == '{"a":1}' &&
          req.headers['Content-Type'] == 'application/json' &&
          req.headers['Authorization'].match(/\Ahmac foo:/)
      }
    end

    it 'sets Authorization header' do

    end
  end
end
