require 'buckaroo_json/transaction'

describe BuckarooJson::Transaction do
  describe '.create' do
    let(:input) do
      {
        mode: 'test',
        website_key: 'foo',
        api_key: 'bar',
        content: {
          'Currency' => 'EUR',
          'AmountDebit' => 1.23
        }
      }
    end
    let(:output) do
      {
        mode: 'test',
        method: 'POST',
        endpoint: 'Transaction',
        website_key: 'foo',
        api_key: 'bar',
        content: {
          'Currency' => 'EUR',
          'AmountDebit' => 1.23
        }
      }
    end

    it 'delegates to Request.create' do
      expect(BuckarooJson::Request).to receive(:create).with(**output)
      described_class.create(**input)
    end

    it 'sends "Services" content to converter' do
      expect(BuckarooJson::Services).to receive(:convert).with(
        [{ 'Name' => 'ideal' }]
      )
      described_class.create(
        **input.merge(
          content: {
            'Services' => [{ 'Name' => 'ideal' }]
          }
        )
      )
    end
  end
end
