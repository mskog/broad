require "spec_helper"

feature "TV Show Search", :js, :feature do
  include ActiveJob::TestHelper

  scenario "User searches for a tv show" do
    visit search_path(search_type: 'tv_shows')

    within('.main') do
      first("input").set('better call saul').native.send_keys(:return)

      expect(page).to have_text('2015')
      expect(page).to have_text('McGill')

      click_button 'Sample'

      expect(page).to have_current_path(episodes_path)
      expect(page).to have_text('The Strain') # This is because of test setup!
    end

  end
end