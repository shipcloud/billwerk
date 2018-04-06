require 'spec_helper'

describe Billwerk do

  it "sets defaults" do
    Billwerk::Configurable.keys.each do |key|
      expect(Billwerk.instance_variable_get(:"@#{key}")).to eq(Billwerk::Default.send(key))
    end
  end

  describe ".client" do
    it "creates an Billwerk::Client" do
      expect(Billwerk.client).to be_kind_of Billwerk::Client
    end

    it "creates new client everytime" do
      expect(Billwerk.client).to_not eq(Billwerk.client)
    end

    it "allows stubbing the method" do
      billwerk_client = instance_double(Billwerk::Client)
      allow(Billwerk).to receive(:client).and_return(billwerk_client)

      expect(Billwerk.client).to be_kind_of RSpec::Mocks::InstanceVerifyingDouble
    end
  end

  describe ".configure" do
    Billwerk::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Billwerk.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Billwerk.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end

end
