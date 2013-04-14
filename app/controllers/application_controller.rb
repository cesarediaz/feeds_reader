class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_channels


  def get_channels
    if user_signed_in?
      @channels = current_user.channels
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    render_404
  end

  def render_404
    flash[:alert] = "404 Not Found!"
    redirect_to root_path
  end

end
