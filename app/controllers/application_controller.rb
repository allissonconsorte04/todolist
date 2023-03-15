class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
