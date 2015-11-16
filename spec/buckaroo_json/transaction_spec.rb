require 'buckaroo_json/transaction'

describe BuckarooJson::Transaction do
  describe '.create' do
    it 'delegates to Request.create' do
      expect(BuckarooJson::Request).to receive(:create).with(
        mode: 'test',
        method: 'POST',
        endpoint: 'Transaction',
        website_key: 'foo',
        api_key: 'bar',
        content: {
          'Currency' => 'EUR',
          'AmountDebit' => 1.23
        }
      )
      described_class.create(
        mode: 'test',
        website_key: 'foo',
        api_key: 'bar',
        content: {
          'Currency' => 'EUR',
          'AmountDebit' => 1.23
        }
      )
    end
  end
end
