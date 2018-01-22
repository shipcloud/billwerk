module PactasItero
  module Api
    module Discounts
      def discounts(options = {})
        options = options.camelize_keys
        get "api/v1/Discounts", options
      end

      def discount(discount_id, options = {})
        options = options.camelize_keys
        get "api/v1/Discounts/#{discount_id}", options
      end

    end
  end
end