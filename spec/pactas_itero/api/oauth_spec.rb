require 'spec_helper'

describe PactasItero::Api::OAuth do

  describe '#token' do
    before do
      stub_post(
        "https://a_client_id:a_client_secret@sandbox.pactas.com/oauth/token"
      ).with(
        :body => { :grant_type => 'client_credentials' }
      ).to_return(
        :status => 200,
        :body => fixture('bearer_token.json'),
        :headers => {
          :content_type => 'application/json; charset=utf-8'
        }
      )
    end

    it 'requests the correct resource' do
      client = PactasItero::Client.new(client_id: 'a_client_id', client_secret: 'a_client_secret')

      client.token

      expect(a_post(
        "https://a_client_id:a_client_secret@sandbox.pactas.com/oauth/token"
      ).with(
        :body => { :grant_type => 'client_credentials' },
        :headers => {
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8'
        }
      )).to have_been_made
    end

    it 'returns the bearer token' do
      client = PactasItero::Client.new(client_id: 'a_client_id', client_secret: 'a_client_secret')
      bearer_token = client.token

      expect(bearer_token.access_token).to eq('top_secret_access_token')
      expect(bearer_token.token_type).to eq('bearer')
      expect(bearer_token.expires).to eq(0)
    end
  end
end
