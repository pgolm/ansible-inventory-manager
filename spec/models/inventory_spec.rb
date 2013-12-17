require 'spec_helper'

describe Inventory do
  let(:admin) { build(:user) }

  subject{ Inventory.new(name: 'Inventar', owner: admin) }

  it { should be_valid }

  it "should have a name" do
    subject.name = ""
    should be_invalid
  end

  describe "#owner" do
    before do
      subject.owner = nil
    end
    
    it { should be_invalid }
  end

  context "#name" do
    describe "same user" do
      before do
        inventory_copy = subject.dup
        inventory_copy.owner = admin
        inventory_copy.save
      end

      it { should be_invalid }
    end

    describe "different users" do
      before do
        inventory_copy = subject.dup
        inventory_copy.owner = build(:user)
        inventory_copy.save
      end

      it { should be_valid }
    end
  end
end
