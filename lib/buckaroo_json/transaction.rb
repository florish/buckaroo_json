require 'buckaroo_json/request'
require 'buckaroo_json/services'

module BuckarooJson
  module Transaction
    class << self
      def create(mode:, website_key:, api_key:, content:)
        Request.create(
          mode: mode,
          website_key: website_key,
          api_key: api_key,
          method: 'POST',
          endpoint: 'Transaction',
          content: convert_services(content)
        )
      end

      private

      def convert_services(content)
        return content unless content.key?('Services')
        content.merge(
          'Services' => Services.convert(content['Services'])
        )
      end
    end
  end
end
