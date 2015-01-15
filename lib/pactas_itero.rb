require 'pactas_itero/client'
require 'pactas_itero/default'

module PactasItero

  class << self
    include PactasItero::Configurable

    # API client based on configured options {Configurable}
    #
    # @return [PactasItero::Client] API wrapper
    def client
      @client = PactasItero::Client.new(options)
      @client
    end

    # @private
    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    # @private
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end

PactasItero.setup
