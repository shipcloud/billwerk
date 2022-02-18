require "spec_helper"

describe PactasItero::Api::Customers do
  describe ".customer_contracts" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/customers/535783241d8dd00fa0db6b2a/contracts").
        to_return(
          body: fixture("contracts.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.customer_contracts("535783241d8dd00fa0db6b2a")

      expect(request).to have_been_made
    end

    it "returns an array of contracts" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/customers/535783241d8dd00fa0db6b2a/contracts").
        to_return(
          body: fixture("contracts.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      contracts = client.customer_contracts("535783241d8dd00fa0db6b2a")

      expect(contracts).to be_a Array
    end
  end

  describe ".contracts" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts").
        to_return(
          body: fixture("contracts.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.contracts

      expect(request).to have_been_made
    end

    it "returns an array of contracts" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts").
        to_return(
          body: fixture("contracts.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      contracts = client.contracts

      expect(contracts).to be_a Array
    end
  end

  describe ".contract_cancellation_preview" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts/some_contract_id/cancellationPreview").to_return(
        body: fixture("contract_cancellation_preview_response.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      client.contract_cancellation_preview("some_contract_id")

      expect(request).to have_been_made
    end

    it "returns the next possible cancellation date" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts/some_contract_id/cancellationPreview").to_return(
        body: fixture("contract_cancellation_preview_response.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      contract_cancellation_preview = client.contract_cancellation_preview("some_contract_id")

      expect(
        contract_cancellation_preview.next_possible_cancellation_date,
      ).to eq "2015-11-15T10:02:21.2750000Z"
    end
  end

  describe ".update_contract" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_patch("/api/v1/contracts/contract-id").
        with(body: { EndDate: "2014-05-23T13:12:47.0760000Z" }.to_json).
        to_return(
          body: fixture("contract.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.update_contract("contract-id", { end_date: "2014-05-23T13:12:47.0760000Z" })

      expect(request).to have_been_made
    end
  end

  describe ".contract" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts/5357bc4f1d8dd00fa0db6c31").
        to_return(
          body: fixture("contract.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.contract("5357bc4f1d8dd00fa0db6c31")

      expect(request).to have_been_made
    end
  end

  describe ".terminate_contract" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_post("/api/v1/contracts/5922f50b81b1f007e0e4d738/end").
        with(
          body: { EndDate: "2017-10-01T14:51:29.3390000Z" }.to_json,
        ).
        to_return(
          body: fixture("contract_termination_response.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.terminate_contract(
        "5922f50b81b1f007e0e4d738",
        end_date: "2017-10-01T14:51:29.3390000Z",
      )

      expect(request).to have_been_made
    end
  end

  describe ".get_self_service_token_for_contract" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/contracts/5357bc4f1d8dd00fa0db6c31/SelfServiceToken").to_return(
        body: fixture("self_service_token.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      client.get_self_service_token_for_contract("5357bc4f1d8dd00fa0db6c31")

      expect(request).to have_been_made
    end

    it "returns a self service token" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/api/v1/contracts/5357bc4f1d8dd00fa0db6c31/SelfServiceToken").to_return(
        body: fixture("self_service_token.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      self_service_token = client.get_self_service_token_for_contract("5357bc4f1d8dd00fa0db6c31")

      expect(self_service_token.token).to eq "522703b9eb596a0f40480825$1378374980$JDBWmg34kr_mFIUFP"
    end
  end
end
