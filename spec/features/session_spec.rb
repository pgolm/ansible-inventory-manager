require "spec_helper"

feature "Session" do
  let(:user) { create(:identity) }

  feature "Login" do
    background do
      visit "/signin"
      fill_in "Email", with: user.email
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
end