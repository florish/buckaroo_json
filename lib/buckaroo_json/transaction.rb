require 'buckaroo_json/request'

module BuckarooJson
  module Transaction
    class << self
      def create(mode:, website_key:, api_key:, **content)
        Request.create(
          mode: mode,
          method: 'POST',
          endpoint: 'Transaction',
          website_key: website_key,
          api_key: api_key,
          **content
        )
      end
    end
  end
end
