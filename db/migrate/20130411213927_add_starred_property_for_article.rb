class AddStarredPropertyForArticle < ActiveRecord::Migration
  def up
    add_column :articles, :starred, :boolean, :default => false
  end

  def down
    remove_column :articles, :starred
  end
end
