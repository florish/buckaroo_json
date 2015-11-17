require 'net/https'
require 'buckaroo_json/uri'

module BuckarooJson
  module Request
    class << self
      def create(mode:, method:, endpoint:, website_key:, api_key:, content:)
        uri = Uri.create(mode: mode, endpoint: endpoint)
        req = Net::HTTP::Post.new(uri.path)
        req.body = content.to_json
        req['Content-Type'] = 'application/json'
        req['Authorization'] = AuthorizationHeader.create(
          website_key: website_key,
          api_key: api_key,
          method: method,
          url: uri,
          content: content.to_json
        )
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.request(req)
      end

      def url_for_mode(mode)
        Uri.create(mode: mode)
      end
    end
  end
end
