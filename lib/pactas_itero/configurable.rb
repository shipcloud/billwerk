module PactasItero
  module Configurable
    attr_accessor :bearer_token, :client_id, :client_secret, :user_agent,
                  :default_media_type, :middleware, :production
    attr_writer :api_endpoint

    class << self
      # List of configurable keys for PactasItero::Client
      def keys
        @keys ||= [
          :bearer_token,
          :api_endpoint,
          :client_id,
          :client_secret,
          :user_agent,
          :default_media_type,
          :middleware,
          :production,
        ]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      PactasItero::Configurable.keys.each do |key|
        send(:"#{key}=", PactasItero::Default.options[key])
      end
      self
    end
    alias setup reset!

    def api_endpoint
      endpoint = @api_endpoint ||
        production && production_api_endpoint ||
        sandbox_api_endpoint
      File.join(endpoint, "")
    end

    def sandbox_api_endpoint
      PactasItero::Default.sandbox_api_endpoint
    end

    def production_api_endpoint
      PactasItero::Default.production_api_endpoint
    end

    private

    def options
      Hash[PactasItero::Configurable.keys.map { |key| [key, send(:"#{key}")] }]
    end
  end
end
