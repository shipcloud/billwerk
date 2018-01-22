module PactasItero
  module Api
    module Contracts
      def customer_contracts(customer_id, options = {})
        options = options.camelize_keys
        get "api/v1/customers/#{customer_id}/contracts", options
      end

      def contracts(options = {})
        options = options.camelize_keys
        get "api/v1/contracts", options
      end

      def update_contract(contract_id, options = {})
        options = options.camelize_keys
        patch "api/v1/contracts/#{contract_id}", options
      end

      def contract(contract_id, options = {})
        options = options.camelize_keys
        get "api/v1/contracts/#{contract_id}", options
      end

      def contract_cancellation_preview(contract_id, options = {})
        options = options.camelize_keys
        get "api/v1/contracts/#{contract_id}/cancellationPreview", options
      end

      def get_self_service_token_for_contract(contract_id, options = {})
        options = options.camelize_keys
        get "api/v1/contracts/#{contract_id}/SelfServiceToken", options
      end

      def terminate_contract(contract_id, options = {})
        options = options.camelize_keys
        post "api/v1/contracts/#{contract_id}/end", options
      end

      def ledger_entries_for_contract(contract_id, options = {})
        options = options.camelize_keys
        get "api/v1/contracts/#{contract_id}/ledgerEntries", options
      end

      def change_payment_method_for_contract(contract_id, options = {})
        options = options.camelize_keys
        post "api/v1/contracts/#{contract_id}/changepaymentmethod", options
      end

      def subscribe_component_for_contract(contract_id, options = {})
        options = options.camelize_keys
        post "api/v1/contracts/#{contract_id}/componentsubscriptions", options

        ## ComponentType:Metered
        ## ComponentType:QuantityBased

      end

    end
  end
end
