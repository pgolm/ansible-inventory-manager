require 'spec_helper'

describe Group do
  let(:inventory) { build(:inventory_with_hosts) }
  subject { Group.new name: 'MyGroup', inventory: inventory, hosts: inventory.hosts }

  it { should be_valid }

  describe "#name" do
    before do
      saved_copy = subject.dup
      saved_copy.save
    end

    specify { expect(subject).to be_invalid }
  end

  describe "#inventory" do
    before do
      subject.inventory = nil
    end

    specify { expect(subject).to be_invalid }
  end

  specify { expect(subject.inventory).to eq(inventory) }
  specify { expect(subject.hosts.length).to eq inventory.hosts.length }
end
