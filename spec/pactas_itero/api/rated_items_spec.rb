require 'spec_helper'

describe PactasItero::Api::RatedItems do
  describe ".create_rated_item" do
    it "requests the correct resource" do
      client = PactasItero::Client.new(bearer_token: 'bt')
      post_data = {
        PeriodStart: '2014-09-19T08:18:51.907Z',
        PeriodEnd: '2014-09-19T08:19:51.907Z',
        Quantity: 2,
        Description: 'the description',
        PricePerUnit: 123.45,
        TaxPolicyId: 'tax-policy-id',
      }.to_json
      request = stub_post('/api/v1/contracts/contract-id/ratedItems').
      with(body: post_data).
      to_return(
        body: fixture('create_rated_item.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.create_rated_item(
        'contract-id',
        2,
        'the description',
        123.45,
        'tax-policy-id',
        {
          period_start: "2014-09-19T08:18:51.907Z",
          period_end: "2014-09-19T08:19:51.907Z"
        }
      )

      expect(request).to have_been_made
    end

    it 'returns the created rated item' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      post_data = {
        PeriodStart: '2014-09-19T08:18:51.907Z',
        PeriodEnd: '2014-09-19T08:19:51.907Z',
        Quantity: 2,
        Description: 'the description',
        PricePerUnit: 123.45,
        TaxPolicyId: 'tax-policy-id',
      }.to_json
      request = stub_post('/api/v1/contracts/contract-id/ratedItems').
      with(body: post_data).
      to_return(
        body: fixture('create_rated_item.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      rated_item = client.create_rated_item(
        'contract-id',
        2,
        'the description',
        123.45,
        'tax-policy-id',
        {
          period_start: "2014-09-19T08:18:51.907Z",
          period_end: "2014-09-19T08:19:51.907Z"
        }
      )

      expect(rated_item.description).to eq 'the description'
      expect(rated_item.period_end).to eq '2014-09-19T08:18:51.907Z'
      expect(rated_item.period_start).to eq '2014-09-19T08:18:51.907Z'
      expect(rated_item.price_per_unit).to eq 123.45
      expect(rated_item.quantity).to eq 2
      expect(rated_item.tax_policy_id).to eq 'tax-policy-id'
    end
  end
end
