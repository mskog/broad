require "spec_helper"

feature "Epidoes", :js, :feature do
  scenario "User visits episodes page" do
    episode = create :episode, tv_show: create(:tv_show), releases: [create(:episode_release)]

    visit "/episodes"

    expect(page).to have_text("Downloads")
    expect(page).to have_text(episode.tv_show.name)
    expect(page).to have_text(episode.name)
  end
end
