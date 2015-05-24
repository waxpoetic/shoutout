require 'rails_helper'

RSpec.feature 'when managing episodes for podcasts', admin: true do
  let :episode do
    episodes :brotherly_audio_one
  end

  let :podcast do
    episode.podcast
  end

  context 'on the podcasts page' do
    before do
      visit podcast_path(podcast)
    end

    scenario 'episodes can be navigated to from the podcast page' do
      click_link 'Edit'

      expect(page).to have_content(episode.title)
    end

    scenario 'new episodes can be uploaded' do
      click_link 'Upload'
      fill_in 'Title', with: 'Episode Name'
      expect(page).to have_content('Save')
      click_button 'Save'

      expect(page).to have_content('New episode has been uploaded.')
      expect(page).to have_content('Episode Name')
    end
  end

  context 'on the episode page' do
    before do
      visit podcast_episode_path(podcast_id: podcast.id, id: episode.id, format: :html)
    end

    scenario 'existing episodes can be edited' do
      fill_in 'Title', with: 'New episode name'
      click_button 'Save'

      expect(page).to have_content('New episode has been uploaded.')
      expect(page).to have_content('New episode name')
    end

    scenario 'existing episodes can be destroyed' do
      visit podcasts_path(podcast, format: :html)

      expect(page).to_not have_content('No episodes')

      click_button 'Delete'

      expect(page).to_not have_content(episode.title)
    end
  end
end
