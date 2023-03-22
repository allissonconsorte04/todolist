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
    return render_blocked_user_error unless @user.enabled?

    @token = user.validation_tokens.create
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
      flash.now[:error] = 'Token inválido'
      render :enter_token, status: :bad_request
    end
  end

  private

  def user
    @user ||= User.find_by(phone: params[:phone])
  end

  def generate_token; end

  def generate_token_and_redirect
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
end
