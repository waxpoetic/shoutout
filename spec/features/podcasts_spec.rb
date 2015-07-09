require 'rails_helper'

RSpec.feature "Podcasts", type: :feature do
  let(:user) { users(:admin) }
  let(:podcast) { podcasts(:brotherly) }

  context 'when not logged in' do
    scenario 'index can not be viewed' do
      visit podcasts_path
      expect(page).to have_content('You must sign in or sign up to continue.')
    end

    scenario 'show can not be viewed' do
      visit podcasts_path(podcast)
      expect(page).to have_content('You must sign in or sign up to continue.')
    end
  end

  context 'when logged in' do
    before { sign_in user }

    scenario 'a collection of podcasts are viewable' do
      visit podcasts_path
      expect(page).to have_content('Podcasts')
    end

    context 'a single podcast' do
      before { visit podcasts_path(podcast) }

      scenario 'is viewable' do
        visit podcasts_path(podcast)
        expect(page).to have_content(podcast.name)
      end

      scenario 'can be edited' do
        fill_in 'Name', with: 'New name'
        click_button 'Save'
        expect(page).to have_content('Podcast has been updated.')
        expect(page).to have_content('New name')
      end
    end
  end
end
