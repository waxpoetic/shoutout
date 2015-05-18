class AddIsVideoToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :is_video, :boolean, default: false
  end
end
