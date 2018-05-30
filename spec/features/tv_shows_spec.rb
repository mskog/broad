require "spec_helper"

feature "TV Shows", :js, :feature do
  scenario "User visits TV Shows page" do
    tv_show = create(:tv_show)

    visit "/tv_shows"

    expect(page).to have_text(tv_show.name)
  end
end
