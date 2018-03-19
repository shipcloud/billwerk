module PactasItero
  module Api
    module Plans
      def plans(options = {})
        options = options.camelize_keys
        get "api/v1/Plans", options
      end

      def plan(plan_id, options = {})
        options = options.camelize_keys
        get "api/v1/plans/#{plan_id}", options
      end

      def create_plan(plangroup_id, options = {})
        options = options.camelize_keys
        post "api/v1/planGroups/#{plangroup_id}/plans", options
      end

      def update_plan(plan_id, options = {})
        options = options.camelize_keys
        patch "api/v1/plans/#{plan_id}", options
      end

      def plan_variants(options = {})
        options = options.camelize_keys
        get "api/v1/planvariants", options
      end

      def plan_variant(planvariant_id, options = {})
        options = options.camelize_keys
        get "api/v1/planvariants/#{planvariant_id}", options
      end

      def create_plan_variant(plan_id, options = {})
        options = options.camelize_keys
        post "api/v1/plans/#{plan_id}/planvariants", options
      end

      def update_plan_variant(planvariant_id, options = {})
        options = options.camelize_keys
        patch "api/v1/planvariants/#{planvariant_id}", options
      end

      def plan_variants_for_plan(plan_id, options = {})
        options = options.camelize_keys
        get "api/v1/plans/#{plan_id}/planvariants", options
      end
    end
  end
end