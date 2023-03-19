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
    return render_blocked_user_error if @user.blocked?
    return render_invalid_phone_error unless @user

    generate_login_token_and_redirect
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  def enter_token
    @user = User.find_by(phone: params[:phone])
  end

  def verify_token
    @user = User.find_by(phone: params[:phone], login_token: params[:token])
    if @user
      update_user_after_login
      session[:user_id] = @user.id
      redirect_to users_path
    else
      update_user_wrong_login(params[:phone])
    end
  end

  private

  def token_generator
    @user = User.find_by(phone: params[:phone])
    random_numbers = []
    6.times do
      random_numbers << rand(10)
    end
    @user.update(login_token: random_numbers.join(''), login_count: 0)
  end

  def update_user_after_login
    @user.update(login_token: nil, login_count: 0)
  end

  def update_user_wrong_login(phone)
    @user = User.find_by(phone:)
    if @user.login_count >= 2
      @user.update(blocked: true)
      render_blocked_user_error
    else
      @user.update(login_count: @user.login_count + 1)
      render_invalid_token(@user)
    end
  end

  def render_invalid_token(user)
    @user = User.find_by(phone: user.phone)

    flash.now[:error] = 'Token inválido'
    render :enter_token, status: :bad_request, locals: { user: @user }
  end

  def render_blocked_user_error
    flash.now[:error] = 'Usuário Bloqueado'
    render :new, status: :bad_request
  end

  def render_invalid_phone_error
    flash.now[:error] = 'Telefone inválido'
    render :new, status: :bad_request
  end

  def generate_login_token_and_redirect
    token_generator
    redirect_to enter_token_session_path(id: @user.id, phone: @user.phone)
  end
end
