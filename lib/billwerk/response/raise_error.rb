require 'faraday'
require 'billwerk/error'

module Billwerk
  # Faraday response middleware
  module Response

    # This class raises an Billwerk-flavored exception based
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware

      private

      def on_complete(response)
        if error = Billwerk::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
