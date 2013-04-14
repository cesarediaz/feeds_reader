ActiveAdmin.register Channel do
  actions :all, :except => [:destroy]
  index do
    column Hpricot.uxs(:name)
    column :created_at
    column "Qty of Articles", proc {|a| a.articles.size}
    default_actions
  end

end
