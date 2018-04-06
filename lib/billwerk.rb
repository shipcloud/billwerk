require 'billwerk/client'
require 'billwerk/default'

module Billwerk
  class << self
    include Billwerk::Configurable

    # API client based on configured options {Configurable}
    #
    # @return [Billwerk::Client] API wrapper
    def client
      Billwerk::Client.new(options)
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

Billwerk.setup
