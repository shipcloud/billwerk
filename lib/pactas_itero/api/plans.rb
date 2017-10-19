module PactasItero
  module Api
    module Plans
      def plans(options = {})
        options = options.camelize_keys
        get "api/v1/Plans", options
      end

      def plan_variants(options = {})
        options = options.camelize_keys
        get "api/v1/PlanVariants", options
      end
    end
  end
end