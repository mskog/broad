require "spec_helper"

feature "Movie Search", :js, :feature do
  include ActiveJob::TestHelper

  scenario "User searches for a movie" do
    visit movie_searches_path

    within('.main') do
      first("input").set('alien').native.send_keys(:return)

      expect(page).to have_text('1979')
      expect(page).to have_text('During')

      perform_enqueued_jobs do
        first('button').click
      end

      expect(page).to have_current_path(movie_waitlists_path)
      expect(page).to have_text('alien')

      page.accept_alert 'Are you sure?' do
        click_button 'Delete'
      end

      visit movie_waitlists_path
      expect(page).to_not have_text('alien')
    end

  end
end