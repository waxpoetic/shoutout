class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :link
      t.string :language, default: 'en-us'
      t.string :copyright
      t.string :subtitle
      t.string :author
      t.string :description
      t.string :email
      t.string :image
      t.string :categories, array: true

      t.timestamps null: false
    end
  end
end
