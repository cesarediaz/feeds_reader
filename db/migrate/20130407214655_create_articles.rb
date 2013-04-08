class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :description
      t.text :link
      t.datetime :pubDate
      t.integer :channel_id
      t.text :guid

      t.timestamps
    end
  end
end
