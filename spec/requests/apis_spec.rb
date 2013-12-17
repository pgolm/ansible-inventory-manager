require 'spec_helper'

describe API::API do

  describe "APIv1" do
    let(:empty_inventory) { create(:inventory) }
    let(:unsafed_inventory) { build(:small_inventory) }
    let(:small_inventory) { create(:small_inventory) }
    let(:admin) { create(:user) }

    it "unauthorized me" do
      get "/api/v1/inventory/#{empty_inventory.key}"
      response.status.should == 401 # unauthorized
    end

    describe "GET inventory" do
      it "didn't found the inventory" do
        get "/api/v1/inventory/#{unsafed_inventory.key}?token=#{admin.api_key}"

        expect(response.status).to eq 404
      end

      it "returns an empty inventory" do
        @expected = {
          all: []
        }.to_json

        get "/api/v1/inventory/#{empty_inventory.key}?token=#{admin.api_key}"

        expect(response.status).to eq 200
        expect(response.body).to eq @expected
      end

      it "returns a inventory with host" do
        @expected = {
          all: [small_inventory.hosts[0].alias],
        }.to_json

        get "/api/v1/inventory/#{small_inventory.key}?token=#{admin.api_key}"
        
        expect(response.status).to eq 200
        expect(response.body).to eq @expected
      end
    end

    describe "GET host" do
      it "didn't found the host" do
        get "/api/v1/inventory/#{small_inventory.key}/#{unsafed_inventory.hosts[0].alias}?token=#{admin.api_key}"

        expect(response.status).to eq 404
      end

      it "return a host withouts variables" do
        get "/api/v1/inventory/#{small_inventory.key}/#{small_inventory.hosts[0].alias}?token=#{admin.api_key}"

        expect(response.status).to eq 200
      end
    end
  end
end
