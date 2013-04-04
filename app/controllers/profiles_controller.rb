class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def show
    @profile = User.find(current_user.id).profile
  end

end
