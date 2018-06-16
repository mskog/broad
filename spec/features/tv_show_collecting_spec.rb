require "spec_helper"

feature "TV Show Collecting", :js, :feature do
  include ActiveJob::TestHelper

  scenario "User searches for a tv show" do
    visit search_path(search_type: 'tv_shows')

    within('.main') do
      first("input").set('better call saul').native.send_keys(:return)

      expect(page).to have_text('2015')
      expect(page).to have_text('McGill')

      click_button 'Collect'

      expect(page).to have_current_path(tv_show_path(TvShow.first))
      expect(page).to have_text('Better Call Saul')
      expect(page).to_not have_button('Collect')
      expect(page).to have_button('Unwatch')

      expect(CollectTvShowJob).to have_been_enqueued

    end
  end
end
