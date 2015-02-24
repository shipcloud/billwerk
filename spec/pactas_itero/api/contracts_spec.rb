require 'spec_helper'

describe PactasItero::Api::Customers do
  describe '.customer_contracts' do
    it 'requests the correct resource' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/customers/535783241d8dd00fa0db6b2a/contracts').
      to_return(
        body: fixture('contracts.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.customer_contracts('535783241d8dd00fa0db6b2a')

      expect(request).to have_been_made
    end

    it 'returns an array of contracts' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/customers/535783241d8dd00fa0db6b2a/contracts').
      to_return(
        body: fixture('contracts.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      contracts = client.customer_contracts('535783241d8dd00fa0db6b2a')

      expect(contracts).to be_a Array
    end
  end

  describe '.contracts' do
    it 'requests the correct resource' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/contracts').
      to_return(
        body: fixture('contracts.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.contracts

      expect(request).to have_been_made
    end

    it 'returns an array of contracts' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/contracts').
      to_return(
        body: fixture('contracts.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      contracts = client.contracts

      expect(contracts).to be_a Array
    end
  end

  describe '.update_contract' do
    it 'requests the correct resource' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_patch('/api/v1/contracts/contract-id').
      with(body: { EndDate: '2014-05-23T13:12:47.0760000Z' }.to_json).
      to_return(
        body: fixture('contract.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.update_contract('contract-id', { end_date: '2014-05-23T13:12:47.0760000Z' })

      expect(request).to have_been_made
    end
  end

  describe '.contract' do
    it 'requests the correct resource' do
      client = PactasItero::Client.new(bearer_token: 'bt')
      request = stub_get('/api/v1/contracts/5357bc4f1d8dd00fa0db6c31').
      to_return(
        body: fixture('contract.json'),
        headers: { content_type: 'application/json; charset=utf-8'}
      )

      client.contract('5357bc4f1d8dd00fa0db6c31')

      expect(request).to have_been_made
    end
  end
end
