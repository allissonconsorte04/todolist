class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.find_by(uuid: params[:uuid])
  end
end
