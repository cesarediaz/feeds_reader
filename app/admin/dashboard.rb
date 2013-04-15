ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard", :locale => :en) } do

    columns do

      column do
        panel "Recent Users Registered" do
          table_for  User.limit(15) do
            column("Login") {|u| status_tag(u.login) }
            column("Email"){|u| u.email }
          end
        end
      end
      column do
        panel "Last Channels" do
          table_for Channel.order('created_at DESC').limit(15).each do |u|
            column(:name) {|c| Hpricot.uxs(c.name) }
            column('Registered at') {|c| c.created_at }
          end
        end
      end
    end
  end # content
end
