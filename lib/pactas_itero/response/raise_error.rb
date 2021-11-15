require "faraday"
require "pactas_itero/error"

module PactasItero
  # Faraday response middleware
  module Response
    # This class raises an PactasItero-flavored exception based
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Middleware
      def on_complete(response)
        if error = PactasItero::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
