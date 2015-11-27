require 'buckaroo_json/request'
require 'webmock/rspec'

describe BuckarooJson::Request do
  describe '.create' do
    context 'POST request' do
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
      it 'sends HTTP request with correct headers and body' do
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
    end

    context 'GET request' do
      let(:input) do
        {
          mode: 'test',
          website_key: 'foo',
          api_key: 'bar',
          method: 'GET',
          endpoint: 'EndPoint2?fooBar=3.0',
          content: nil
        }
      end
      it 'sends HTTP request with correct headers and body' do
        stub_request(
          :get,
          'https://testcheckout.buckaroo.nl/json/EndPoint2?fooBar=3.0'
        )
        subject.create(**input)
        expect(WebMock).to have_requested(
          :get,
          'https://testcheckout.buckaroo.nl/json/EndPoint2?fooBar=3.0'
        ).with { |req|
          req.body.nil? &&
            req.headers['Accept'] == 'application/json' &&
            req.headers['Authorization'].match(/\Ahmac foo:/)
        }
      end
    end
  end
end
