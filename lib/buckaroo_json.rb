require 'buckaroo_json/transaction'
require 'buckaroo_json/transaction_specification'
require 'buckaroo_json/version'

module BuckarooJson
  def self.transaction(content = {})
    Transaction.create(**configuration.merge(content: content))
  end

  def self.transaction_specification(service, version: '3.0')
    TransactionSpecification.create(
      **configuration.merge(
        service: service,
        version: version
      )
    )
  end

  private

  def self.configuration
    {
      mode: ENV['BUCKAROO_JSON_MODE'] || 'test',
      website_key: ENV['BUCKAROO_JSON_WEBSITE_KEY'],
      api_key: ENV['BUCKAROO_JSON_API_KEY']
    }
  end
end
