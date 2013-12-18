require "spec_helper"

feature "Session" do
  let(:user) { create(:identity) }

  context "Login" do
    before :each do
      OmniAuth.config.test_mode = false
      visit "/signin"
      fill_in "Email", with: user.email
    end

    after do
      OmniAuth.config.test_mode = true
    end

    scenario "Success" do
      fill_in "Password", with: user.password
      click_button "Login"

      expect(page).to have_text("Signed in!")
    end

    scenario "Denied" do
      fill_in "Password", with: "#{user.password}_failed"
      click_button "Login"

      expect(page).to have_text("not authorized")
    end
  end

  scenario "Logout" do
    set_user_session user
    visit "/"
    click_link "Logout"

    expect(page).to have_text("not authorized")
  end
end