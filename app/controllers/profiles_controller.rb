class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_profile, :only => [:show, :edit, :update, :destroy]

  def new
    @profile = Profile.new
  end

  def create
    params[:profile][:user_id] = current_user.id
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to(@profile)
    else
      render :action => "new"
    end

  end

  def show
  end

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profile_path
  end

  private

  def get_profile
    @profile = Profile.find_by_user_id(current_user.id)
  end
end
