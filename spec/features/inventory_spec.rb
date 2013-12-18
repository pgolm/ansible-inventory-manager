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

  context "Add Inventory" do
    before do
      visit inventories_path
      click_link "new_inventory"
    end

    scenario "Success" do
      fill_in "Name", with: "#{inventory.name}_new"
      click_on "Create"
      
      expect(page).to have_text("Inventory was created.")
    end

    scenario "Fail" do
      fill_in "Name", with: inventory.name
      click_on "Create"

      expect(page).to have_text("has already")
    end
  end

  scenario "Edit Inventory" do
    visit inventories_path
    click_link "edit_inventory"
    fill_in "Name", with: "#{inventory.name}_edit"
    click_on "Update"
    
    expect(page).to have_text("Inventory was updated.")
  end

  scenario "Delete Inventory" do
    visit inventories_path
    click_link "delete_#{inventory.name}"
    
    expect(page).to have_text("Inventory was deleted.")
  end
end