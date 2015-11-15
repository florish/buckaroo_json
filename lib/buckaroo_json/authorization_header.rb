require 'base64'
require 'openssl'
require 'securerandom'
require 'uri'

module BuckarooJson
  module AuthorizationHeader
    class << self
      def create(website_key:, api_key:, method:, url:, content: nil)
        timestamp = current_timestamp
        nonce = current_nonce
        base64_hash = hmac_sha256_hash(
          secret: api_key,
          message: hmac_sha256_message(
            website_key, method, url, timestamp, nonce, content
          )
        )
        "hmac #{website_key}:#{base64_hash}:#{nonce}:#{timestamp}"
      end

      def hmac_sha256_hash(secret:, message:)
        hash = OpenSSL::HMAC.digest('sha256', secret, message)
        Base64.encode64(hash).strip
      end

      def hmac_sha256_message(website_key, method, url, timestamp, nonce, content)
        website_key +
          method +
          normalized_url(url) +
          timestamp.to_s +
          nonce +
          content_hash(content)
      end

      def normalized_url(raw_url)
        url = URI(raw_url)
        url_parts = url.host + url.path
        url_parts += '?' + url.query if url.query
        CGI.escape(url_parts).downcase
      end

      def content_hash(content)
        return '' if content.nil? || content == ''
        Digest::MD5.base64digest(content)
      end

      def current_timestamp
        Time.now.getutc.to_i
      end

      def current_nonce
        SecureRandom.hex
      end
    end
  end
end
