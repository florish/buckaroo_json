require 'uri'

module BuckarooJson
  module Uri
    class << self
      def create(mode:, endpoint:)
        URI.join("https://#{subdomain(mode)}.buckaroo.nl", 'json/', endpoint)
      end

      def subdomain(mode)
        return 'checkout' if mode == 'production'
        'testcheckout'
      end
    end
  end
end
