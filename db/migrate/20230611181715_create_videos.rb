class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.text :title
      t.text :description
      t.string :duration
      t.text :thumbnail_url
      t.text :tags
      t.datetime :published_at

      t.timestamps
    end
  end
end
