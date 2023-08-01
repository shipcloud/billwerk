# frozen_string_literal: true

require "spec_helper"

# rubocop:disable RSpec/FilePath
describe PactasItero::Api::OAuth do
  describe "#token" do
    it "requests the correct resource" do
      client_credentials_request = stub_post("https://sandbox.billwerk.com/oauth/token").with(
        basic_auth: %w[a_client_id a_client_secret],
        body: "grant_type=client_credentials",
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
        }
      )

      client = PactasItero::Client.new(client_id: "a_client_id", client_secret: "a_client_secret")

      client.token

      expect(client_credentials_request).to have_been_made
    end

    it "returns the bearer token" do
      stub_post("https://sandbox.billwerk.com/oauth/token").with(
        basic_auth: %w[a_client_id a_client_secret],
        body: "grant_type=client_credentials",
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
        }
      ).to_return(
        status: 200,
        body: fixture("bearer_token.json"),
        headers: {
          content_type: "application/json; charset=utf-8"
        }
      )

      client = PactasItero::Client.new(client_id: "a_client_id", client_secret: "a_client_secret")
      bearer_token = client.token

      expect(bearer_token.access_token).to eq("top_secret_access_token")
      expect(bearer_token.token_type).to eq("bearer")
      expect(bearer_token.expires).to eq(0)
    end
  end
end
# rubocop:enable RSpec/FilePath
