require 'pactas_itero/ext/hash/camelize_keys'
require 'pactas_itero/api/oauth'
require 'pactas_itero/api/rated_items'
require 'pactas_itero/api/customers'
require 'pactas_itero/api/contracts'
require 'pactas_itero/api/orders'
require 'pactas_itero/api/invoices'
require "pactas_itero/api/payment_transactions"
require "pactas_itero/api/plans"
require "pactas_itero/api/coupons"
require "pactas_itero/api/discounts"

module PactasItero
  module Api
    include PactasItero::Api::OAuth
    include PactasItero::Api::RatedItems
    include PactasItero::Api::Customers
    include PactasItero::Api::Contracts
    include PactasItero::Api::Orders
    include PactasItero::Api::Invoices
    include PactasItero::Api::PaymentTransactions
    include PactasItero::Api::Plans
    include PactasItero::Api::Coupons
    include PactasItero::Api::Discounts
  end
end
