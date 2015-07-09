class EpisodesController < ApplicationController
  expose :podcast

  resource :episode, ancestor: :podcast do
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
    respond_with podcast, change: 'episodes'
  end

  def update
    episode.update_attributes(edit_params)
    respond_with podcast, change: 'episodes'
  end

  def destroy
    episode.destroy
    respond_with podcast, change: 'episodes'
  end
end
