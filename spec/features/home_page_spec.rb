require 'rails_helper'

RSpec.feature 'home page' do
  let :podcast do
    podcasts :brotherly_audio
  end

  let :user do
    users :admin
  end

  scenario 'renders the login page when not logged in' do
    logout :user
    visit root_path
    expect(page).to have_content('Sign in')
  end

  scenario 'shows all of your podcasts when logged in' do
    login_as user, scope: :user
    visit root_path
    expect(page).to have_content(podcast.title)
    expect(page).to have_content(podcast.subtitle)
    expect(page).to have_content('New Podcast')
  end
end
