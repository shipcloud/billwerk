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
      
      def create_discount(plangroup_id, options = {})
        options = options.camelize_keys
        post "api/v1/planGroups/#{plangroup_id}/discounts", options
      end

      def update_discount(discount_id, options = {})
        options = options.camelize_keys
        patch "api/v1/discount/#{discount_id}", options
      end

    end
  end
end