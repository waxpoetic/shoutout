class PodcastsController < ApplicationController
  resource :podcast do
    modify :title, :link, :language, :copyright, :subtitle, :author, :description, :email, :image, :categories
  end

  def index
    respond_with podcasts
  end

  def show
    respond_with podcast
  end

  def create
    podcast.save
    respond_with podcast
  end

  def update
    podcast.update_attributes edit_params
    respond_with podcast
  end

  def destroy
    podcast.destroy
    respond_with podcasts_path
  end

  def deploy
    podcast.deploy
    respond_with podcast
  end
end
