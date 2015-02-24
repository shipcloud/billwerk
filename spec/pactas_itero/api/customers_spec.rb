require 'spec_helper'

describe PactasItero::Api::Customers do
  describe ".customers" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/customers').
      to_return(
        body: fixture('customers.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.customers

      expect(request).to have_been_made
    end

    it 'returns an array of customers' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/customers').
      to_return(
        body: fixture('customers.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      customers = client.customers

      expect(customers).to be_a Array
      customer = customers.first

      expect(customer.company_name).to eq 'Example Company'
      expect(customer.created_at).to eq '2014-05-12T14:22:24.0000000Z'
      expect(customer.customer_name).to eq 'Example Company'
      expect(customer.customer_type).to eq 'Consumer'
      expect(customer.default_bearer_medium).to eq 'Email'
      expect(customer.email_address).to eq 'jane.doe@example.com'
      expect(customer.external_customer_id).to eq ''
      expect(customer.first_name).to eq 'Jane'
      expect(customer.id).to eq '5370d9201d8dd006288221b0'
      expect(customer.language).to eq 'de-DE'
      expect(customer.last_name ).to eq 'Doe'
      expect(customer.locale).to eq 'de-DE'
      expect(customer.vat_id).to eq 'DE123456710'
      expect(customer.address.city).to eq 'Example City'
      expect(customer.address.country).to eq 'DE'
      expect(customer.address.house_number).to eq '42'
      expect(customer.address.postal_code).to eq '12345'
      expect(customer.address.street).to eq 'Example Street'
    end
  end

  describe '.update_customer' do
    it 'requests the correct resource' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_patch('/api/v1/customers/customer-id').
      with(
        body: {
          CompanyName: 'example & sons',
          VatId: 'DE555',
          Address: { Street: 'abc street' }
        }.to_json
      ).
      to_return(
        body: fixture('customer.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.update_customer('customer-id', {
        company_name: 'example & sons',
        vat_id: 'DE555',
        address: { street: 'abc street' }
      })

      expect(request).to have_been_made
    end
  end
end
