require "spec_helper"

feature "Session" do
  let(:identity) { create(:identity) }
  let(:known_identity) { create(:known_identity) }

  context "Login" do
    before :each do
      OmniAuth.config.test_mode = false
      visit "/signin"
      fill_in "Email", with: identity.email
    end

    after :all do
      OmniAuth.config.test_mode = true
    end

    scenario "Success" do
      fill_in "Password", with: identity.password
      click_button "Login"

      expect(page).to have_text("Signed in!")
    end

    scenario "Denied" do
      fill_in "Password", with: "#{identity.password}_failed"
      click_button "Login"

      expect(page).to have_text("not authorized")
    end
  end

  scenario "Logout" do
    set_user_session known_identity
    visit "/"
    click_link "Logout"

    expect(page).to have_text("not authorized")
  end
end