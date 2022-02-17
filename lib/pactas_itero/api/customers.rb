# frozen_string_literal: true
module PactasItero
  module Api
    module Customers
      def create_customer(options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        post "api/v1/customers", options
      end

      def customers(options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        get "api/v1/customers", options
      end

      def customer(customer_id, options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        get "api/v1/customers/#{customer_id}", options
      end

      def update_customer(customer_id, options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        patch "api/v1/customers/#{customer_id}", options
      end
    end
  end
end
