class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @article = Article.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @article = Article.find(params[:comment][:article_id])
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Your comment was added succesfully!'
      redirect_to :controller => 'home', :action => 'index', :channel_id => @comment.article.channel.id
    else
      render :action => "new"
    end
  end

end
