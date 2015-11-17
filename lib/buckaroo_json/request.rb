require 'net/https'
require 'buckaroo_json/uri'

module BuckarooJson
  module Request
    class << self
      def create(mode:, method:, endpoint:, website_key:, api_key:, content:)
        uri = checkout_uri(mode: mode, endpoint: endpoint)
        req = request_for_method(
          method: method,
          uri: uri,
          content: content.to_json,
          website_key: website_key,
          api_key: api_key
        )
        response(host: uri.host, port: uri.port, request: req)
      end

      def checkout_uri(mode:, endpoint:)
        Uri.create(mode: mode, endpoint: endpoint)
      end

      def request_for_method(method:, **args)
        get(**args) if method == 'GET'
        post(**args) if method == 'POST'
      end

      def get(**_args)
        fail NotImplementedError
      end

      def post(uri:, content:, website_key:, api_key:)
        Net::HTTP::Post.new(uri.path).tap do |req|
          req.body = content
          req['Content-Type'] = 'application/json'
          req['Authorization'] = create_authorization_header(
            website_key: website_key,
            api_key: api_key,
            method: 'POST',
            url: uri,
            content: content
          )
        end
      end

      def response(host:, port:, request:)
        http = Net::HTTP.new(host, port)
        http.use_ssl = true
        http.request(request)
      end

      def create_authorization_header(**args)
        AuthorizationHeader.create(**args)
      end
    end
  end
end
