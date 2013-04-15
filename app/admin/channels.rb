ActiveAdmin.register Channel do
  actions :all, :except => [:destroy]
  index do
    column Hpricot.uxs(:name)
    column :created_at
    column "Qty of Articles", proc {|a| a.articles.size}
    default_actions
  end

  collection_action :index, :method => :get do
    scope = Channel.scoped
    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))
  end

end
