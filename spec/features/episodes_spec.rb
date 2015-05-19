require 'rails_helper'

RSpec.feature 'when managing episodes for podcasts', admin: true do
  let :episode do
    episodes :brotherly_audio_one
  end

  let :podcast do
    episode.podcast
  end

  scenario 'episodes can be navigated to from the podcast page' do
    visit podcasts_path(podcast)

    click_link 'Edit'

    expect(page).to have_content(episode.title)
  end

  scenario 'new episodes can be uploaded' do
    visit episodes_path(episode)

    click_link 'Upload'
    fill_in 'Title', with: 'Episode Name'
    click_button 'Save'

    expect(page).to have_content('New episode has been uploaded.')
    expect(page).to have_content('Episode Name')
  end

  scenario 'existing episodes can be edited' do
    visit episodes_path(episode)

    fill_in 'Title', with: 'New episode name'
    click_button 'Save'

    expect(page).to have_content('New episode has been uploaded.')
    expect(page).to have_content('New episode name')
  end

  scenario 'existing episodes can be destroyed' do
    visit podcasts_path(podcast)

    click_button 'Delete'

    expect(page).to_not have_content(episode.title)
  end
end
