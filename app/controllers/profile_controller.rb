class ProfileController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user = current_user
  end

  def update
    return unless current_user.update(username: params[:username], email: params[:email])
    
    redirect_to profile_index_path
  end
end
