require 'spec_helper'

describe Host do
  let(:inventory) { build(:inventory_with_groups) }
  subject { Host.new alias: 'Myhost', inventory: inventory, groups: inventory.groups }

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
  specify { expect(subject.groups.length).to eq inventory.groups.length }
end
