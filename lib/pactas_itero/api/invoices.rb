# frozen_string_literal: true
module PactasItero
  module Api
    module Invoices
      def invoices(options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        get "api/v1/invoices", options
      end

      def invoices_from(from_id = nil, options = {}) # rubocop:disable Style/OptionHash
        if from_id
          options = options.camelize_keys
          get "api/v1/invoices?from=#{from_id}", options
        else
          invoices(options)
        end
      end

      def invoice(invoice_id, options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        get "api/v1/invoices/#{invoice_id}", options
      end

      def invoice_download(invoice_id, options = {}) # rubocop:disable Style/OptionHash
        options = options.camelize_keys
        get "api/v1/invoices/#{invoice_id}/download", options
      end
    end
  end
end
