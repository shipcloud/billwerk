require "spec_helper"

describe PactasItero::Api::Invoices do
  describe ".invoices" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices").
        to_return(
          body: fixture("invoices.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.invoices

      expect(request).to have_been_made
    end

    it "returns an array of contracts" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices").
        to_return(
          body: fixture("invoices.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      invoices = client.invoices

      expect(invoices).to be_a Array
    end
  end

  describe ".invoices_from" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices?from=54b67d9e995ec90bc8f37718").
        to_return(
          body: fixture("invoices.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.invoices_from("54b67d9e995ec90bc8f37718")

      expect(request).to have_been_made
    end

    it "requests the correct resource, if from parameter is nil" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices").
        to_return(
          body: fixture("invoices.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.invoices_from(nil)

      expect(request).to have_been_made
    end

    it "returns an array of contracts" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices?from=54b67d9e995ec90bc8f37718").
        to_return(
          body: fixture("invoices.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      invoices = client.invoices_from("54b67d9e995ec90bc8f37718")

      expect(invoices).to be_a Array
    end
  end

  describe ".invoice" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices/54b67d9e995ec90bc8f37718").
        to_return(
          body: fixture("invoice.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.invoice("54b67d9e995ec90bc8f37718")

      expect(request).to have_been_made
    end
  end

  describe ".invoice_download" do
    it "returns the pdf as a string after requesting the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/invoices/54b67d9e995ec90bc8f37718/download").
        to_return(
          body: fixture("invoice_download.pdf"),
          headers: { content_type: "application/pdf" },
        )

      response = client.invoice_download("54b67d9e995ec90bc8f37718")

      expect(request).to have_been_made
      expect(response.class).to be String
    end
  end
end
