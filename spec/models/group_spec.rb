require 'spec_helper'

describe Group do
  let(:empty_inventory) { build(:inventory) }
  subject { Group.new name: 'MyGroup', inventory: empty_inventory }

  it { should be_valid }
  specify { expect(subject.inventory).to eq(empty_inventory)  }
end
