require "spec_helper"

describe PactasItero::Api::Customers do
  describe ".create_customer" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      post_data = {
        "Address" => {
          "City" => "Example City",
          "Country" => "DE",
          "HouseNumber" => "42",
          "PostalCode" => "12345",
          "Street" => "Example Street",
        },
        "CompanyName" => "Example Company",
        "DefaultBearerMedium" => "Email",
        "EmailAddress" => "jane.doe@example.com",
        "ExternalCustomerId" => "1234",
        "FirstName" => "Jane",
        "Language" => "de-DE",
        "LastName" => "Doe",
        "Locale" => "de-DE",
        "VatId" => "DE123456710",
      }.to_json
      request = stub_post("/api/v1/customers").with(body: post_data).to_return(
        body: fixture("customer.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      client.create_customer(
        address: {
          city: "Example City",
          country: "DE",
          house_number: "42",
          postal_code: "12345",
          street: "Example Street",
        },
        company_name: "Example Company",
        default_bearer_medium: "Email",
        email_address: "jane.doe@example.com",
        external_customer_id: "1234",
        first_name: "Jane",
        language: "de-DE",
        last_name: "Doe",
        locale: "de-DE",
        vat_id: "DE123456710",
      )

      expect(request).to have_been_made
    end

    it "returns the created customer" do
      client = PactasItero::Client.new(bearer_token: "bt")
      post_data = {
        "Address" => {
          "City" => "Example City",
          "Country" => "DE",
          "HouseNumber" => "42",
          "PostalCode" => "12345",
          "Street" => "Example Street",
        },
        "CompanyName" => "Example Company",
        "DefaultBearerMedium" => "Email",
        "EmailAddress" => "jane.doe@example.com",
        "ExternalCustomerId" => "1234",
        "FirstName" => "Jane",
        "Language" => "de-DE",
        "LastName" => "Doe",
        "Locale" => "de-DE",
        "VatId" => "DE123456710",
      }.to_json
      request = stub_post("/api/v1/customers").with(body: post_data).to_return(
        body: fixture("customer.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      customer = client.create_customer(
        address: {
          city: "Example City",
          country: "DE",
          house_number: "42",
          postal_code: "12345",
          street: "Example Street",
        },
        company_name: "Example Company",
        default_bearer_medium: "Email",
        email_address: "jane.doe@example.com",
        external_customer_id: "1234",
        first_name: "Jane",
        language: "de-DE",
        last_name: "Doe",
        locale: "de-DE",
        vat_id: "DE123456710",
      )

      address = customer.address
      expect(address.city).to eq "Example City"
      expect(address.country).to eq "DE"
      expect(address.house_number).to eq "42"
      expect(address.postal_code).to eq "12345"
      expect(address.street).to eq "Example Street"

      expect(customer.company_name).to eq "Example Company"
      expect(customer.default_bearer_medium).to eq "Email"
      expect(customer.email_address).to eq "jane.doe@example.com"
      expect(customer.external_customer_id).to eq "1234"
      expect(customer.first_name).to eq "Jane"
      expect(customer.language).to eq "de-DE"
      expect(customer.last_name).to eq "Doe"
      expect(customer.locale).to eq "de-DE"
      expect(customer.vat_id).to eq "DE123456710"
    end
  end

  describe ".customers" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/customers").
        to_return(
          body: fixture("customers.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.customers

      expect(request).to have_been_made
    end

    it "returns an array of customers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/api/v1/customers").
        to_return(
          body: fixture("customers.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      customers = client.customers

      expect(customers).to be_a Array
      customer = customers.first

      expect(customer.company_name).to eq "Example Company"
      expect(customer.created_at).to eq "2014-05-12T14:22:24.0000000Z"
      expect(customer.customer_name).to eq "Example Company"
      expect(customer.customer_type).to eq "Consumer"
      expect(customer.default_bearer_medium).to eq "Email"
      expect(customer.email_address).to eq "jane.doe@example.com"
      expect(customer.external_customer_id).to eq ""
      expect(customer.first_name).to eq "Jane"
      expect(customer.id).to eq "5370d9201d8dd006288221b0"
      expect(customer.language).to eq "de-DE"
      expect(customer.last_name).to eq "Doe"
      expect(customer.locale).to eq "de-DE"
      expect(customer.vat_id).to eq "DE123456710"
      expect(customer.address.city).to eq "Example City"
      expect(customer.address.country).to eq "DE"
      expect(customer.address.house_number).to eq "42"
      expect(customer.address.postal_code).to eq "12345"
      expect(customer.address.street).to eq "Example Street"
    end
  end

  describe ".customer" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bearer_token")
      request = stub_get("/api/v1/customers/customer-id").to_return(
        body: fixture("customer.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      client.customer("customer-id")

      expect(request).to have_been_made
    end

    it "returns the customer details" do
      client = PactasItero::Client.new(bearer_token: "bearer_token")
      stub_get("/api/v1/customers/customer-id").to_return(
        body: fixture("customer.json"),
        headers: { content_type: "application/json; charset=utf-8" },
      )

      customer = client.customer("customer-id")

      address = customer.address
      expect(address.city).to eq "Example City"
      expect(address.country).to eq "DE"
      expect(address.house_number).to eq "42"
      expect(address.postal_code).to eq "12345"
      expect(address.street).to eq "Example Street"

      expect(customer.company_name).to eq "Example Company"
      expect(customer.default_bearer_medium).to eq "Email"
      expect(customer.email_address).to eq "jane.doe@example.com"
      expect(customer.external_customer_id).to eq "1234"
      expect(customer.first_name).to eq "Jane"
      expect(customer.language).to eq "de-DE"
      expect(customer.last_name).to eq "Doe"
      expect(customer.locale).to eq "de-DE"
      expect(customer.vat_id).to eq "DE123456710"
    end
  end

  describe ".update_customer" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_patch("/api/v1/customers/customer-id").
        with(
          body: {
            CompanyName: "example & sons",
            VatId: "DE555",
            Address: { Street: "abc street" },
          }.to_json,
        ).
        to_return(
          body: fixture("customer.json"),
          headers: { content_type: "application/json; charset=utf-8" },
        )

      client.update_customer(
        "customer-id", {
          company_name: "example & sons",
          vat_id: "DE555",
          address: { street: "abc street" },
        }
      )

      expect(request).to have_been_made
    end
  end
end
