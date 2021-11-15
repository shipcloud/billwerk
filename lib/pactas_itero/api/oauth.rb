module PactasItero
  module Api
    module OAuth
      def token(options = {})
        options[:bearer_token_request] = true
        options[:grant_type] ||= "client_credentials"
        post "/oauth/token", options
      end
    end
  end
end
