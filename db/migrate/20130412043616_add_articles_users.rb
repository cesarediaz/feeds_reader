class AddArticlesUsers < ActiveRecord::Migration
  def change
    create_table :articles_users do |t|
      t.integer :article_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
