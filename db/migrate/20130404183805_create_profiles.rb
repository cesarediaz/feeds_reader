class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :profile_type
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
