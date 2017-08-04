# frozen_string_literal: true
require "spec_helper"

describe PactasItero::Api::PaymentTransactions do
  describe ".payment_transaction" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bearer_token")
      request = stub_get("/api/v1/PaymentTransactions/payment_transaction_id").to_return(
        body: fixture("payment_transaction.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      client.payment_transaction("payment_transaction_id")

      expect(request).to have_been_made
    end

    it "returns the payment transaction details" do
      client = PactasItero::Client.new(bearer_token: "bearer_token")
      stub_get("/api/v1/PaymentTransactions/payment_transaction_id").to_return(
        body: fixture("payment_transaction.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      transaction = client.payment_transaction("payment_transaction_id")

      expect(transaction.amount).to eq 11.89
      expect(transaction.contract_id).to eq "592d74a981b1f010f04293a4"
      expect(transaction.currency).to eq "EUR"
      expect(transaction.customer_id).to eq "592d74a881b1f010f04293a2"
      expect(transaction.customer_name).to eq "Example Company"
      expect(transaction.id).to eq "597de03d81b1ef0d18a46f4e"
      expect(transaction.payment_provider).to eq "Example Provider"
      expect(transaction.payment_provider_role).to eq "CreditCard"
      expect(transaction.preauth).to eq false
      expect(transaction.provider_transaction_id).to eq "ccec718e-271e-4d0e-b0e1-94894e40c0c7"
      expect(transaction.status).to eq(
        "amount" => 11.89,
        "http_code" => 0,
        "preauth" => false,
        "status" => "Succeeded",
        "timestamp" => "2017-07-30T13:33:49.9900000Z",
      )
      expect(transaction.status_history).to eq(
        [
          {
            "amount" => 11.89,
            "http_code" => 0,
            "preauth" => false,
            "status" => "InProgress",
            "timestamp" => "2017-07-30T13:33:49.9760000Z",
          },
          {
            "amount" => 11.89,
            "http_code" => 0,
            "preauth" => false,
            "status" => "Succeeded",
            "timestamp" => "2017-07-30T13:33:49.9900000Z",
          },
        ],
      )
      expect(transaction.status_timestamp).to eq "2017-07-30T13:33:49.9900000Z"
      expect(transaction.trigger).to eq "Recurring"
    end
  end
end
