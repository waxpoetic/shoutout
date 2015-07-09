require 'rails_helper'

RSpec.feature "Podcasts", type: :feature do
  let(:user) { users(:admin) }
  let(:podcast) { podcasts(:brotherly_audio) }

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

  def t(id)
    I18n.translate!(id, resource_name: 'Podcast')
  end

  scenario 'new podcasts can be created' do
    visit podcasts_path

    click_link 'Manage New Podcast'

    fill_in 'Title',        with: 'Title of Podcast'
    fill_in 'Link',         with: 'http://example.com'
    fill_in 'Copyright',    with: '&copy; 2000 The Author'
    fill_in 'Subtitle',     with: 'Short description'
    fill_in 'Author',       with: 'Lester Tester'
    fill_in 'Description',  with: 'Long description of Podcast'
    fill_in 'Email',        with: 'user@example.com'
    click_button 'Save'

    expect(page).to have_content(t('flash.actions.create.notice'))
  end

  scenario 'existing podcasts can be edited' do
    visit podcast_path(podcast)

    fill_in 'Title', with: 'New title of podcast'
    click_button 'Save'

    expect(page).to have_content('Podcast was successfully updated.')
    expect(page).to have_content('New title of podcast')
  end

  scenario 'existing podcasts can be destroyed' do
    visit podcasts_path

    expect(page).to have_content(podcast.title)

    click_link 'Delete'

    expect(page).not_to have_content(podcast.title)
  end
end
