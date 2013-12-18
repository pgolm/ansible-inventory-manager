require "spec_helper"

feature "Inventory" do
  let(:user) { create(:identity) }
  let!(:inventory) { create(:inventory_with_groups_hosts, owner: User.find_by(email: user.email)) }

  before do
    set_user_session user
  end

  scenario "Overview" do
    visit inventories_path
    expect(page).to have_text(inventory.name)
  end
end