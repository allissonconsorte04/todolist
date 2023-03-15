class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(phone: params[:phone])

    if @user
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash.now[:alert] = 'Telefone inválido'
      render :new, status: :bad_request
    end
  end
end
