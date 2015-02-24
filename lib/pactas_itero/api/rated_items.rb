module PactasItero
  module Api
    module RatedItems
      def create_rated_item(contract_id, quantity, description, price_per_unit, tax_policy_id, options = {})
        options.merge!(
          quantity: quantity,
          description: description,
          price_per_unit: price_per_unit,
          tax_policy_id: tax_policy_id
        )
        options = options.camelize_keys
        post "api/v1/contracts/#{contract_id}/ratedItems", options
      end
    end
  end
end
