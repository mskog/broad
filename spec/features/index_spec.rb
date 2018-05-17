require "spec_helper"

feature "Home page", :js, :feature do
  scenario "User visits home page" do
    visit "/"

    expect(page).to have_text("Downloads")
    expect(page).to have_text("Episodes")
  end
end