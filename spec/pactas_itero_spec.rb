# frozen_string_literal: true

require "spec_helper"

describe PactasItero do
  it "sets defaults" do
    PactasItero::Configurable.keys.each do |key|
      expect(described_class.instance_variable_get(:"@#{key}")).to(
        eq(PactasItero::Default.send(key))
      )
    end
  end

  describe ".client" do
    it "creates an PactasItero::Client" do
      expect(described_class.client).to be_kind_of PactasItero::Client
    end

    it "creates new client everytime" do
      expect(described_class.client).not_to eq(described_class.client)
    end

    it "allows stubbing the method" do
      pactas_client = instance_double(PactasItero::Client)
      allow(described_class).to receive(:client).and_return(pactas_client)

      expect(described_class.client).to be_kind_of RSpec::Mocks::InstanceVerifyingDouble
    end
  end

  describe ".configure" do
    PactasItero::Configurable.keys.each do |key|
      it "sets the #{key.to_s.tr("_", " ")}" do
        described_class.configure do |config|
          config.send("#{key}=", key)
        end
        expect(described_class.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end
end
