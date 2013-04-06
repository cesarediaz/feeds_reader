class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.text :url
      t.text :name
      t.integer :user_id

      t.timestamps
    end
  end
end
