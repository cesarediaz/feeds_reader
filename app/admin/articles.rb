ActiveAdmin.register Article do
  actions :all, :except => [:destroy]
  index do
    column :title
    column :created_at
    column "Belongs to", proc {|a| link_to Hpricot.uxs(a.channel.name), admin_channel_path(a.channel)}
    column "Qty of comments", proc {|a| a.comments.size}
    default_actions
  end

end
