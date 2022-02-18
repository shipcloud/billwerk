require "pactas_itero/client"
require "pactas_itero/default"

module PactasItero
  class << self
    include PactasItero::Configurable

    # API client based on configured options {Configurable}
    #
    # @return [PactasItero::Client] API wrapper
    def client
      PactasItero::Client.new(options)
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name != :client && client.respond_to?(method_name, include_private) || super
    end

    private

    def method_missing(method_name, *args, &block)
      if method_name != :client && client.respond_to?(method_name)
        client.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end

PactasItero.setup
