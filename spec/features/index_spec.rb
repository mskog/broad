require "spec_helper"

feature "Home page", :js, :feature do
  scenario "User visits home page" do
    create :episode, download_at: Date.today, tv_show: create(:tv_show), tmdb_details: nil
    create :episode, download_at: Date.yesterday, tv_show: create(:tv_show), tmdb_details: nil

    visit "/"

    expect(page).to have_text("Downloads")
    expect(page).to have_text("Episodes")
  end
end
