require 'buckaroo_json'

describe BuckarooJson do
  it 'has a version number' do
    expect(BuckarooJson::VERSION).not_to be nil
  end

  describe '.transaction' do
    it 'delegates to submodule' do
      expect(BuckarooJson::Transaction).to receive(:create).with(
        mode: 'test',
        website_key: nil,
        api_key: nil,
        content: { foo: 'bar' }
      )
      described_class.transaction(foo: 'bar')
    end
  end

  describe '.transaction_specification' do
    it 'delegates to submodule' do
      expect(BuckarooJson::TransactionSpecification).to receive(:create).with(
        mode: 'test',
        website_key: nil,
        api_key: nil,
        service: 'foo',
        version: '3.0'
      )
      described_class.transaction_specification('foo')
    end
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it 'default to test mode with empty values' do
      expect(subject).to eq(
        mode: 'test',
        website_key: nil,
        api_key: nil
      )
    end

    it 'reads in ENV settings if given' do
      allow(ENV).to receive(:[]).with('BUCKAROO_JSON_MODE').and_return(:foo)
      allow(ENV).to receive(:[]).with('BUCKAROO_JSON_WEBSITE_KEY').and_return(:bar)
      allow(ENV).to receive(:[]).with('BUCKAROO_JSON_API_KEY').and_return(:bax)
      expect(subject).to eq(
        mode: :foo,
        website_key: :bar,
        api_key: :bax
      )
    end
  end
end
