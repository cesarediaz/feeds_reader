ActiveAdmin.register User do
  actions :all, :except => [:destroy]
  index do
    column :login
    column :email
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  collection_action :index, :method => :get do
    scope = User.scoped
    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))
  end

end
