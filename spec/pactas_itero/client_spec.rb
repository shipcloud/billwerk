require "spec_helper"
require "json"

describe PactasItero::Client do
  before do
    PactasItero.reset!
  end

  describe "module configuration" do
    before do
      PactasItero.configure do |config|
        PactasItero::Configurable.keys.each do |key|
          config.send("#{key}=", "the #{key} value")
        end
      end
    end

    it "inherits the module configuration" do
      client = PactasItero::Client.new

      PactasItero::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq("the #{key} value")
      end
    end

    describe "with class level configuration" do
      before do
        @opts = {
          # connection_options: {ssl: {verify: false}},
          client_id: "the_client_id",
          client_secret: "the_client_secret",
        }
      end

      it "overrides module configuration" do
        client = PactasItero::Client.new(@opts)

        expect(client.client_id).to eq("the_client_id")
        expect(client.client_secret).to eq("the_client_secret")
        expect(client.user_agent).to eq(PactasItero.user_agent)
      end

      it "can set configuration after initialization" do
        client = PactasItero::Client.new
        client.configure do |config|
          @opts.each do |key, value|
            config.send("#{key}=", value)
          end
        end

        expect(client.client_id).to eq("the_client_id")
        expect(client.client_secret).to eq("the_client_secret")
        expect(client.user_agent).to eq(PactasItero.user_agent)
      end
    end
  end

  describe ".get" do
    it "requests the given resource using get" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/something?foo=bar")

      client.get "/something", foo: "bar"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/").
        with(query: { foo: "bar" }, headers: { accept: "text/plain" })
      client.get "/", foo: "bar", accept: "text/plain"

      expect(request).to have_been_made
    end
  end

  describe ".head" do
    it "requests the given resource using head" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_head("/something?foo=bar")

      client.head "/something", foo: "bar"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_head("/").
        with(query: { foo: "bar" }, headers: { accept: "text/plain" })

      client.head "/", foo: "bar", accept: "text/plain"

      expect(request).to have_been_made
    end
  end

  describe ".post" do
    it "requests the given resource using post" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_post("/something").
        with(body: { foo: "bar" }.to_json)

      client.post "/something", foo: "bar"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      headers = { "X-Foo" => "bar" }
      request = stub_post("/").
        with(body: { foo: "bar" }.to_json, headers: headers)

      client.post "/", foo: "bar", headers: headers

      expect(request).to have_been_made
    end
  end

  describe ".put" do
    it "requests the given resource using put" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_put("/something").
        with(body: { foo: "bar" }.to_json)

      client.put "/something", foo: "bar"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      headers = { "X-Foo" => "bar" }
      request = stub_put("/").
        with(body: { foo: "bar" }.to_json, headers: headers)

      client.put "/", foo: "bar", headers: headers

      expect(request).to have_been_made
    end
  end

  describe ".patch" do
    it "requests the given resource using patch" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_patch("/something").
        with(body: { foo: "bar" }.to_json)

      client.patch "/something", foo: "bar"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      headers = { "X-Foo" => "bar" }
      request = stub_patch("/").
        with(body: { foo: "bar" }.to_json, headers: headers)

      client.patch "/", foo: "bar", headers: headers

      expect(request).to have_been_made
    end
  end

  describe ".delete" do
    it "requests the given resource using delete" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_delete("/something")

      client.delete "/something"

      expect(request).to have_been_made
    end

    it "passes along request headers" do
      client = PactasItero::Client.new(bearer_token: "bt")
      headers = { "X-Foo" => "bar" }
      request = stub_delete("/").with(headers: headers)

      client.delete "/", headers: headers

      expect(request).to have_been_made
    end
  end

  describe "when making requests" do
    it "uses the sandbox endpoint by default" do
      client = PactasItero::Client.new

      expect(client.api_endpoint).to eq "https://sandbox.billwerk.com/"
    end

    it "uses the production endpoint when production is set to true" do
      client = PactasItero::Client.new(production: true)

      expect(client.api_endpoint).to eq "https://app.billwerk.com/"
    end

    it "sets a default user agent" do
      client = PactasItero::Client.new(bearer_token: "bt")
      request = stub_get("/").
        with(headers: { user_agent: PactasItero::Default.user_agent })

      client.get "/"

      expect(request).to have_been_made
    end

    it "accepts a custom user agent" do
      user_agent = "Mozilla/1.0 (Win3.1)"
      client = PactasItero::Client.new(user_agent: user_agent, bearer_token: "bt")
      request = stub_get("/").with(headers: { user_agent: user_agent })

      client.get "/"

      expect(request).to have_been_made
    end

    it "creates the correct auth headers with supplied bearer_token" do
      token = "the_bearer_token"
      request = stub_get("/").with(headers: { authorization: "Bearer #{token}" })
      client = PactasItero::Client.new(bearer_token: token)

      client.get "/"

      expect(request).to have_been_made
    end

    it "creates the correct auth headers with supplied bearer_token" do
      token = OpenStruct.new(access_token: "the_bearer_token")
      client = PactasItero::Client.new(bearer_token: token)

      request = stub_get("/").with(headers: { authorization: "Bearer #{token.access_token}" })

      client.get "/"

      expect(request).to have_been_made
    end
  end

  context "error handling" do
    it "raises on 404" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/four_oh_four").to_return(status: 404)

      expect { client.get("/four_oh_four") }.to raise_error PactasItero::NotFound
    end

    it "raises on 500" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/five_oh_oh").to_return(status: 500)

      expect { client.get("/five_oh_oh") }.to raise_error PactasItero::InternalServerError
    end

    it "includes a message" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/with_message").to_return(
        status: 422,
        headers: { content_type: "application/json" },
        body: { Message: "'Something' is not a valid ObjectId. Expected a 24 digit hex string." }.to_json,
      )

      expect { client.get("/with_message") }.to raise_error(
        PactasItero::UnprocessableEntity,
        "GET https://sandbox.billwerk.com/with_message: " \
          "422 - 'Something' is not a valid ObjectId. Expected a 24 digit hex string.",
      )
    end

    it "raises a ClientError on unknown client errors" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/something").to_return(
        status: 418,
        headers: { content_type: "application/json" },
        body: { message: "I'm a teapot" }.to_json,
      )

      expect { client.get("/something") }.to raise_error PactasItero::ClientError
    end

    it "raises a ServerError on unknown server errors" do
      client = PactasItero::Client.new(bearer_token: "bt")
      stub_get("/something").to_return(
        status: 509,
        headers: { content_type: "application/json" },
        body: { message: "Bandwidth exceeded" }.to_json,
      )

      expect { client.get("/something") }.to raise_error PactasItero::ServerError
    end
  end

  describe ".sandbox_api_endpoint" do
    it "returns url of the sandbox endpoint" do
      client = PactasItero::Client.new

      expect(client.sandbox_api_endpoint).to eq "https://sandbox.billwerk.com"
    end
  end

  describe ".production_api_endpoint" do
    it "returns url of the sandbox endpoint" do
      client = PactasItero::Client.new

      expect(client.production_api_endpoint).to eq "https://app.billwerk.com"
    end
  end
end
