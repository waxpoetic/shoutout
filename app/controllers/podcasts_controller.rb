class PodcastsController < ApplicationController
  respond_to :html, :rss
  skip_before_action :authenticate_user!, only: [:show]

  resource :podcast do
    modify :title, :link, :language, :copyright, :subtitle, :author, :description, :email, :image, :categories
  end

  def index
    respond_with podcasts
  end

  def new
    render :new
  end

  def show
    respond_with podcast
  end

  def create
    podcast.save
    respond_with podcast
  end

  def update
    podcast.update_attributes(edit_params)
    respond_with podcast
  end

  def destroy
    podcast.destroy
    respond_with podcasts_path, change: 'podcasts'
  end

  def deploy
    if DeployPodcastJob.perform_later(podcast)
      redirect_to podcast, notice: I18n.t('flash.actions.deploy.notice')
    else
      redirect_to podcast, alert: I18n.t('flash.actions.deploy.alert')
    end
  end
end
