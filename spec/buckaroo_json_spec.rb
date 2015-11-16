require 'spec_helper'

describe BuckarooJson do
  it 'has a version number' do
    expect(BuckarooJson::VERSION).not_to be nil
  end

  describe '.create_transaction' do
    it 'delegates to submodule' do
      expect(BuckarooJson::Transaction).to receive(:create).with(
        mode: 'test',
        website_key: nil,
        api_key: nil,
        foo: 'bar'
      )
      described_class.create_transaction(foo: 'bar')
    end
  end
end
