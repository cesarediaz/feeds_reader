class AddChannelsUsers < ActiveRecord::Migration
  def change
    create_table :channels_users do |t|
      t.integer :channel_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
