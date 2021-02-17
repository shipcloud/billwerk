module PactasItero
  module Api
    module Invoices
      def invoices(options = {})
        options = options.camelize_keys
        get "api/v1/invoices", options
      end

      def invoices_from(from_id = nil, options = {})
        if from_id
          options = options.camelize_keys
          get "api/v1/invoices?from=#{from_id}", options
        else
          invoices(options)
        end
      end

      def invoice(invoice_id, options = {})
        options = options.camelize_keys
        get "api/v1/invoices/#{invoice_id}", options
      end

      def invoice_download(invoice_id, options = {})
        options = options.camelize_keys
        get "api/v1/invoices/#{invoice_id}/download", options
      end
    end
  end
end
