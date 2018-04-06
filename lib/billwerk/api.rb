require 'billwerk/ext/hash/camelize_keys'
require 'billwerk/api/oauth'
require 'billwerk/api/rated_items'
require 'billwerk/api/customers'
require 'billwerk/api/contracts'
require 'billwerk/api/orders'
require 'billwerk/api/invoices'
require "billwerk/api/payment_transactions"

module Billwerk
  module Api
    include Billwerk::Api::OAuth
    include Billwerk::Api::RatedItems
    include Billwerk::Api::Customers
    include Billwerk::Api::Contracts
    include Billwerk::Api::Orders
    include Billwerk::Api::Invoices
    include Billwerk::Api::PaymentTransactions
  end
end
