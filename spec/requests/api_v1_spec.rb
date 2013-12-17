require 'spec_helper'

describe API::API do

  describe "APIv1" do
    let(:empty_inventory) { create(:inventory) }
    let(:unsafed_inventory) { build(:inventory_with_hosts) }
    let(:host_inventory) { create(:inventory_with_hosts) }
    let(:group_inventory) { create(:inventory_with_group) }
    let(:admin) { create(:user) }

    it "unauthorized me" do
      get "/api/v1/inventory/#{empty_inventory.key}"
      expect(response.status).to eq 401 # unauthorized
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

      it "returns a inventory with hosts" do
        @expected = {
          all: host_inventory.hosts.map(&:alias),
        }.to_json

        get "/api/v1/inventory/#{host_inventory.key}?token=#{admin.api_key}"
        
        expect(response.status).to eq 200
        expect(response.body).to eq @expected
      end

      it "returns an inventory with groups" do
        @expected = {
          all: [],
        }
        group_inventory.groups.each do |group|
          @expected[group.name] = {hosts: [], vars:{} }
        end

        get "/api/v1/inventory/#{group_inventory.key}?token=#{admin.api_key}"
        
        expect(response.status).to eq 200
        expect(response.body).to eq @expected.to_json
      end
    end

    describe "GET host" do
      it "didn't found the host" do
        get "/api/v1/inventory/#{host_inventory.key}/#{unsafed_inventory.hosts[0].alias}?token=#{admin.api_key}"

        expect(response.status).to eq 404
      end

      it "return a host withouts variables" do
        get "/api/v1/inventory/#{host_inventory.key}/#{host_inventory.hosts[0].alias}?token=#{admin.api_key}"

        expect(response.status).to eq 200
      end
    end
  end
end
