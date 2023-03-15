class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    if current_user
      redirect_to users_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(phone: params[:phone])

    if @user
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash.now[:error] = 'Telefone inválido'
      render :new, status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
