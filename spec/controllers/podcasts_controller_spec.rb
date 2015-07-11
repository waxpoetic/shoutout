require 'rails_helper'

RSpec.describe PodcastsController, type: :controller do
  let :admin do
    users :admin
  end

  before do
    sign_in admin
  end

  let :podcast do
    podcasts :brotherly_audio
  end

  it 'shows a podcast in rss format' do
    get :show, id: podcast.id, format: :rss

    expect(response).to be_success
  end

  it 'deploys a podcast to s3' do
    get :deploy, id: podcast.id

    expect(response).to be_redirect
    expect(response).to redirect_to(podcast)
    expect(flash[:notice]).to eq(I18n.t('flash.actions.deploy.notice'))
  end
end
