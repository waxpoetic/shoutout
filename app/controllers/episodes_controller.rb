class EpisodesController < ApplicationController
  expose :podcast

  resource :episode do
    #ancestor :podcast
    search :title, :author, :subtitle, :summary, :published_at, :duration
    modify :title, :author, :subtitle, :summary, :image, :enclosure, :published_at, :duration
  end

  def show
    respond_with episode
  end

  def new
    render :new
  end

  def create
    episode.save
    respond_with episode
  end

  def update
    episode.update_attributes edit_params
    respond_with episode
  end

  def destroy
    episode.destroy
    respond_with episodes_path
  end
end
