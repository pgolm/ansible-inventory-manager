require "spec_helper"

feature "Session" do
  let(:user) { create(:identity) }

  scenario "Login" do
    visit "/signin"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_text("Signed in!")
  end
end