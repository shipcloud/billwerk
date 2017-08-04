# frozen_string_literal: true

module PactasItero
  module Api
    module PaymentTransactions
      def payment_transaction(payment_transaction_id)
        get "api/v1/PaymentTransactions/#{payment_transaction_id}"
      end
    end
  end
end
