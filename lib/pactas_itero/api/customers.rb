module PactasItero
  module Api
    module Customers
      def customers(options = {})
        options = options.camelize_keys
        get "api/v1/customers", options
      end

      def update_customer(customer_id, options = {})
        options = options.camelize_keys
        patch "api/v1/customers/#{customer_id}", options
      end
    end
  end
end
