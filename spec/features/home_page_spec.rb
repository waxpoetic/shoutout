require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  let(:user) { users(:admin) }

  context 'when logged in' do
    before { sign_in user }

    scenario 'renders a table of podcasts' do
      visit root_path
      expect(page).to have_content('Podcasts')
    end
  end

  context 'when not logged in' do
    scenario 'prompts the user to log in' do
      visit root_path
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
      expect(page).to have_content('Sign In')
    end
  end
end
