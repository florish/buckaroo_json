require 'buckaroo_json/request'

module BuckarooJson
  module TransactionSpecification
    class << self
      def create(mode:, website_key:, api_key:, service:, version:)
        Request.create(
          mode: mode,
          website_key: website_key,
          api_key: api_key,
          method: 'GET',
          endpoint: endpoint(service, version),
          content: nil
        )
      end

      private

      def endpoint(service, version)
        "Transaction/Specification/#{service}?serviceVersion=#{version}"
      end
    end
  end
end
