ActiveAdmin.register User do
  actions :all, :except => [:destroy]
  index do
    column :login
    column :email
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
end
