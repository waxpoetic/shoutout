require 'rails_helper'

RSpec.feature 'when managing podcast feeds', admin: true do
  let :podcast do
    podcasts :brotherly_audio
  end

  scenario 'new podcasts can be created' do
    visit new_podcast_path

    fill_in 'Title', with: 'Title of Podcast'
    click_button 'Save'

    expect(page).to have_content('New podcast has been created.')
  end

  scenario 'existing podcasts can be edited' do
    visit podcast_path(podcast)

    fill_in 'Title', with: 'New title of podcast'
    click_button 'Save'

    expect(page).to have_content('New podcast has been created.')
    expect(page).to have_content('New title of podcast')
  end

  scenario 'existing podcasts can be destroyed' do
    visit podcasts_path

    click_button 'Destroy'

    expect(page).not_to have_content(podcast.title)
  end
end
