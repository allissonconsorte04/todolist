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
    return render_invalid_phone_error unless @user.present?
    return render_blocked_user_error if @user.blocked?    
    @token = @user.validation_tokens.create
    redirect_to enter_token_session_path(@user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  def enter_token
    @user = User.find(params[:id])
  end

  def verify_token
    @user = User.find(params[:user_id])
    @validation_token = ValidationToken.find_by(token: params[:token])

    if @user.valid_token?(params[:token])
      # update_user_after_login
      @validation_token.create_validation_token_deny_list
      session[:user_id] = @user.id
      redirect_to users_path
    else
      handle_failed_attempt
    end
  end

  private

  def handle_failed_attempt
    @user.failed_login_attempts.create

    if @user.max_attempts_reached?
      flash.now[:error] = 'Máximo de tentativas atingidas, tente novamente mais tarde!'
      @user.update!(blocked_at: DateTime.now)
      redirect_to new_session_path
    else
      flash.now[:error] = 'Token inválido'
      render :enter_token, status: :bad_request
    end
  end

  def render_blocked_user_error
    flash.now[:error] = 'Usuário Bloqueado'
    render :new, status: :bad_request
  end

  def render_invalid_phone_error
    flash.now[:error] = 'Telefone inválido'
    render :new, status: :bad_request
  end
end
