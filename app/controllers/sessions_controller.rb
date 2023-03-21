require_dependency 'login_token'

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
    @token = LoginToken.find(params[:id])
  end

  def verify_token
    @token = LoginToken.find_by(user: User.find_by(phone: params[:phone]), login_token: params[:token])
    if @token
      if @token.expired?

        binding.pry

        flash.now[:error] = 'Esse token já expirou. Por favor, solicite um novo token.'
        render :enter_token, status: :bad_request
      else
        update_user_after_login
        session[:user_id] = @token.user.id
        redirect_to users_path
      end
    else
      update_user_wrong_login(params[:phone])
    end
  end

  private

  def token_generator_and_redirect
    @user = User.find_by(phone: params[:phone])
    token = @user.login_token
    if token.present? && !token.expired?
      redirect_to enter_token_session_path(id: token.id)
    else
      if token.present?
        token.update(login_token: SecureRandom.random_number(10**6),
                     expires_at: Time.now + 3.minutes,
                     login_count: 0)
      else
        token = LoginToken.create(user: @user,
                                  login_token: SecureRandom.random_number(10**6),
                                  expires_at: Time.now + 3.minutes,
                                  login_count: 0)
      end
      redirect_to enter_token_session_path(id: token.id)
    end
  end

  def update_user_after_login
    @token.update(login_count: 0)
  end

  def update_user_wrong_login(phone)
    @token = LoginToken.find_by(user: User.find_by(phone:))

    if @token.login_count >= 2
      @token.user.update(blocked: true)
      render_blocked_user_error
    else
      @token.update(login_count: @token.login_count + 1)
      render_invalid_token(@token.user)
    end
  end

  def render_invalid_token(user)
    @user = User.find_by(phone: user.phone)

    flash.now[:error] = 'Token inválido'
    render :enter_token, status: :bad_request, locals: { token: @token }
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
    token_generator_and_redirect
  end
end
