require "base64"
require "rash"
require "pactas_itero/configurable"
require "pactas_itero/api"

module PactasItero
  class Client
    include PactasItero::Configurable
    include PactasItero::Api

    attr_accessor :bearer_token

    def initialize(options = {})
      PactasItero::Configurable.keys.each do |key|
        instance_variable_set(
          :"@#{key}",
          options[key] || PactasItero.instance_variable_get(:"@#{key}"),
        )
      end
    end

    def get(url, options = {})
      request :get, url, options
    end

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
    end

    def patch(url, options = {})
      request :patch, url, options
    end

    def delete(url, options = {})
      request :delete, url, options
    end

    def head(url, options = {})
      request :head, url, options
    end

    def bearer_token?
      !!bearer_token
    end

    private

    def connection
      @connection ||= Faraday.new(api_endpoint, connection_options)
    end

    def request(method, path, params = {})
      headers = params.delete(:headers) || {}
      if accept = params.delete(:accept)
        headers[:accept] = accept
      end

      bearer_token_request = params.delete(:bearer_token_request)

      if bearer_token_request
        headers[:accept]        = "*/*"
        headers[:authorization] = bearer_token_credentials_auth_header
        headers[:content_type]  = "application/x-www-form-urlencoded; charset=UTF-8"
      else
        headers[:authorization] = auth_header
      end

      response = connection.send(method.to_sym, path, params) do |request|
        request.headers.update(headers)
      end.env
      response.body
    end

    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: {
          accept: default_media_type,
          user_agent: user_agent,
        },
        request: {
          open_timeout: 10,
          timeout: 30,
        },
      }
    end

    def bearer_token_credentials_auth_header
      basic_auth_token = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      "Basic #{basic_auth_token}"
    end

    def bearer_auth_header
      token =
        if bearer_token.respond_to?(:access_token)
          bearer_token.access_token
        else
          bearer_token
        end
      "Bearer #{token}"
    end

    def auth_header
      @bearer_token = token unless bearer_token?
      bearer_auth_header
    end
  end
end
