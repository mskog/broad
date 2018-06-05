require "spec_helper"

feature "TV Shows", :js, :feature do
  scenario "User visits TV Shows page" do
    tv_show = create(:tv_show)

    visit "/tv_shows"

    expect(page).to have_text(tv_show.name)

    click_link(tv_show.name)

    expect(page).to have_text(tv_show.name)

    click_button 'Watch'

    click_button 'Unwatch'

    expect(page).to have_selector(:link_or_button, 'Watch')
  end
end
