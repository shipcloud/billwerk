module Billwerk

  module Configurable
    attr_accessor :bearer_token, :client_id, :client_secret, :user_agent,
                  :default_media_type, :middleware, :production
    attr_writer :api_endpoint
    class << self

      # List of configurable keys for Billwerk::Client
      def keys
        @keys ||= [
          :bearer_token,
          :api_endpoint,
          :client_id,
          :client_secret,
          :user_agent,
          :default_media_type,
          :middleware,
          :production
        ]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      Billwerk::Configurable.keys.each do |key|
        send(:"#{key}=", Billwerk::Default.options[key])
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
      Billwerk::Default.sandbox_api_endpoint
    end

    def production_api_endpoint
      Billwerk::Default.production_api_endpoint
    end

    private

    def options
      Hash[Billwerk::Configurable.keys.map{|key| [key, send(:"#{key}")]}]
    end
  end
end
