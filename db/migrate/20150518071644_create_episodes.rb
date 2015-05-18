class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.references :podcast, index: true, foreign_key: true
      t.string :title
      t.string :author
      t.string :subtitle
      t.string :summary
      t.string :image_id
      t.string :enclosure_id
      t.datetime :published_at
      t.string :duration

      t.timestamps null: false
    end
  end
end
