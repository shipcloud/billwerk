# frozen_string_literal: true
module PactasItero
  module Api
    module Orders
      def create_order(options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        post "api/v1/orders", options
      end

      def order(order_id, options = {}) # rubocop:disable Style/OptionHash
        get "api/v1/orders/#{order_id}", options
      end

      def commit_order(order_id, options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        post "api/v1/orders/#{order_id}/commit", options
      end
    end
  end
end
