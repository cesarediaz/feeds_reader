class AddSuperadminToUser < ActiveRecord::Migration
  def up
    add_column :users, :superadmin, :boolean,
                                    :null => false,
                                    :default => false
    add_column :admin_users, :superadmin, :boolean,
                                    :null => false,
                                    :default => true
  end

  def down
    remove_column :users, :superadmin
    remove_column :admin_users, :superadmin
  end

end
