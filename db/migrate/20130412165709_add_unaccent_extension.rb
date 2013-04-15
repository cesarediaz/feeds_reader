class AddUnaccentExtension < ActiveRecord::Migration

  def up
    execute "su -"
    execute "create extension unaccent"
    execute "exit"
  end

  def down
    execute "drop extension unaccent"
  end
end
