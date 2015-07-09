class PodcastsController < ApplicationController
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
    respond_to do |format|
      format.html # show.html.haml
      format.rss  # show.rss.erb
    end
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
    DeployPodcastJob.perform_later(podcast)
    respond_with podcast, notice: 'Podcast is being deployed'
  end
end
