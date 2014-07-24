class AddSearchIndexForArticles < ActiveRecord::Migration
  def up
    #execute "create index articles_title on articles using gin(to_tsvector('english', title))"
    #execute "create index articles_description on articles using gin(to_tsvector('english', description))"
  end

  def down
    #execute "drop index articles_title"
    #execute "drop index articles_description"
  end
end
