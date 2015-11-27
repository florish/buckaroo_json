require 'buckaroo_json/transaction'
require 'buckaroo_json/version'

module BuckarooJson
  def self.transaction(content = {})
    Transaction.create(**configuration.merge(content: content))
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
