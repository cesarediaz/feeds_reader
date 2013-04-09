class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_channels

  def get_channels
    if user_signed_in?
      @channels = current_user.channels
    end
  end

end
