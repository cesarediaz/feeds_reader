ActiveAdmin.register Comment do
  index do
    column "Content", proc {|c| c.content.truncate(30, :separator => '..')}
    column "Belongs to User", proc {|c| c.user.login}
    column "Belongs to Article", proc {|c| link_to c.article.title, admin_article_path(c.article), :target => '_blank'}
    default_actions
  end

end
