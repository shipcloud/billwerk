require 'billwerk/response/raise_error'
require 'billwerk/version'
require 'faraday_middleware'

module Billwerk

  # Default configuration options for {Client}
  module Default

    SANDBOX_API_ENDPOINT = "https://sandbox.billwerk.com".freeze

    PRODUCTION_API_ENDPOINT = "https://app.billwerk.com".freeze

    PRODUCTION = false

    USER_AGENT   = "Billwerk Ruby Gem #{Billwerk::VERSION}".freeze

    MEDIA_TYPE   = "application/json"

    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      builder.request :json
      builder.use Billwerk::Response::RaiseError
      builder.response :rashify
      builder.request :url_encoded
      builder.response :json, :content_type => /\bjson$/

      builder.adapter Faraday.default_adapter
    end

    class << self

      def options
        Hash[Billwerk::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def api_endpoint
        ENV['BILLWERK_ENDPOINT']
      end

      def sandbox_api_endpoint
        SANDBOX_API_ENDPOINT
      end

      def production_api_endpoint
        PRODUCTION_API_ENDPOINT
      end

      def production
        PRODUCTION
      end

      def client_id
        ENV['BILLWERK_CLIENT_ID']
      end

      def client_secret
        ENV['BILLWERK_CLIENT_SECRET']
      end

      def bearer_token
        ENV['BILLWERK_BEARER_TOKEN']
      end

      def default_media_type
        ENV['BILLWERK_CLIENT_DEFAULT_MEDIA_TYPE'] || MEDIA_TYPE
      end

      def middleware
        MIDDLEWARE
      end

      def user_agent
        ENV['BILLWERK_USER_AGENT'] || USER_AGENT
      end
    end
  end
end
