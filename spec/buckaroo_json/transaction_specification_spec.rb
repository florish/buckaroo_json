require 'buckaroo_json/transaction_specification'

describe BuckarooJson::TransactionSpecification do
  describe '.create' do
    let(:input) do
      {
        mode: 'test',
        website_key: 'foo',
        api_key: 'bar',
        service: 'bax',
        version: 'quux'
      }
    end
    let(:output) do
      {
        mode: 'test',
        website_key: 'foo',
        api_key: 'bar',
        method: 'GET',
        endpoint: 'Transaction/Specification/bax?serviceVersion=quux',
        content: nil
      }
    end

    it 'delegates to Request.create' do
      expect(BuckarooJson::Request).to receive(:create).with(**output)
      described_class.create(**input)
    end
  end
end
