module PactasItero
  module Api
    module Components
      def components(options = {})
        options = options.camelize_keys
        get "api/v1/components", options
      end

      def component(component_id, options = {})
        options = options.camelize_keys
        get "api/v1/components/#{component_id}", options
      end

      def update_component(component_id, options = {})
        options = options.camelize_keys
        patch "api/v1/components/#{component_id}", options
      end

    end
  end
end