require "spec_helper"

describe PactasItero do
  it "sets defaults" do
    PactasItero::Configurable.keys.each do |key|
      expect(PactasItero.instance_variable_get(:"@#{key}")).to eq(PactasItero::Default.send(key))
    end
  end

  describe ".client" do
    it "creates an PactasItero::Client" do
      expect(PactasItero.client).to be_kind_of PactasItero::Client
    end

    it "creates new client everytime" do
      expect(PactasItero.client).to_not eq(PactasItero.client)
    end

    it "allows stubbing the method" do
      pactas_client = instance_double(PactasItero::Client)
      allow(PactasItero).to receive(:client).and_return(pactas_client)

      expect(PactasItero.client).to be_kind_of RSpec::Mocks::InstanceVerifyingDouble
    end
  end

  describe ".configure" do
    PactasItero::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        PactasItero.configure do |config|
          config.send("#{key}=", key)
        end
        expect(PactasItero.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end
end
