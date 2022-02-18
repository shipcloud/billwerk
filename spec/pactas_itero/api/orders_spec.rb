require "spec_helper"

describe PactasItero::Api::Orders do
  describe ".create_order" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      post_data = {
        ContractId: "5370e5ab9e40071fd01e01e0",
        Cart: {
          PlanVariantId: "525bf9089e40073a58590fd5",
        },
      }.to_json
      request = stub_post("/api/v1/orders").
        with(body: post_data).
        to_return(
          body: fixture("create_order_response.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.create_order(
        contract_id: "5370e5ab9e40071fd01e01e0",
        cart: {
          plan_variant_id: "525bf9089e40073a58590fd5",
        },
      )

      expect(request).to have_been_made
    end

    it "returns the created order" do
      client = PactasItero::Client.new(bearer_token: "bt")
      post_data = {
        ContractId: "5370e5ab9e40071fd01e01e0",
        Cart: {
          PlanVariantId: "525bf9089e40073a58590fd5",
        },
      }.to_json
      request = stub_post("/api/v1/orders").
        with(body: post_data).
        to_return(
          body: fixture("create_order_response.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      order = client.create_order(
        contract_id: "5370e5ab9e40071fd01e01e0",
        cart: {
          plan_variant_id: "525bf9089e40073a58590fd5",
        },
      )

      expect(order.id).to eq "537dfcab9e400760b4cd6347"
      expect(order.contract_id).to eq "5370e5ab9e40071fd01e01e0"
    end
  end

  describe ".order" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/orders/5357bc4f1d8dd00fa0db6c31").
        to_return(
          body: fixture("order.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.order("5357bc4f1d8dd00fa0db6c31")

      expect(request).to have_been_made
    end
  end

  describe ".commit_order" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_post("/api/v1/orders/537dfcab9e400760b4cd6347/commit").
        with(body: {}.to_json).
        to_return(
          body: fixture("commit_order_response.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.commit_order("537dfcab9e400760b4cd6347")

      expect(request).to have_been_made
    end

    it "returns the updated contract" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_post("/api/v1/orders/537dfcab9e400760b4cd6347/commit").
        with(body: {}.to_json).
        to_return(
          body: fixture("commit_order_response.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      contract = client.commit_order("537dfcab9e400760b4cd6347")

      expect(contract.id).to eq "5370e5ab9e40071fd01e01e0"
      expect(contract.current_phase.plan_variant_id).to eq "525bf9089e40073a58590fd5"
    end
  end
end
