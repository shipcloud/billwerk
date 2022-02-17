# frozen_string_literal: true
require "pactas_itero/response/raise_error"
require "pactas_itero/version"
require "faraday_middleware"

module PactasItero
  # Default configuration options for {Client}
  module Default
    SANDBOX_API_ENDPOINT = "https://sandbox.billwerk.com"

    PRODUCTION_API_ENDPOINT = "https://app.billwerk.com"

    PRODUCTION = false

    USER_AGENT   = "Pactas.Itero Ruby Gem #{PactasItero::VERSION}"

    MEDIA_TYPE   = "application/json"

    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      builder.request :json
      builder.use PactasItero::Response::RaiseError
      builder.response :rashify
      builder.request :url_encoded
      builder.response :json, content_type: /\bjson$/

      builder.adapter Faraday.default_adapter
    end

    class << self
      def options
        PactasItero::Configurable.keys.to_h { |key| [key, send(key)] }
      end

      def api_endpoint
        ENV["PACTAS_ITERO_ENDPOINT"]
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
        ENV["PACTAS_ITERO_CLIENT_ID"]
      end

      def client_secret
        ENV["PACTAS_ITERO_CLIENT_SECRET"]
      end

      def bearer_token
        ENV["PACTAS_ITERO_BEARER_TOKEN"]
      end

      def default_media_type
        ENV["PACTAS_ITERO_CLIENT_DEFAULT_MEDIA_TYPE"] || MEDIA_TYPE
      end

      def middleware
        MIDDLEWARE
      end

      def user_agent
        ENV["PACTAS_ITERO_USER_AGENT"] || USER_AGENT
      end
    end
  end
end
