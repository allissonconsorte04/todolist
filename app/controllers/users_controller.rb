class UsersController < ApplicationController
  include ApplicationHelper

  skip_before_action :authenticate_user!, only: %i[new create]

  def index
    @users = User.all.order(:id)

    if params[:query].present?
      @users = @users.where('LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?', "%#{params[:query].downcase}%",
                            "%#{params[:query].downcase}%")
    end

    if params[:profile_type] != 'Todos' && params[:profile_type].present?
      @users = @users.where(profile_type: User.profile_types[params[:profile_type]])
    end

    @users = @users.paginate(page: params[:page], per_page: params[:per_page])

    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'search'
        format.html { render partial: 'users_table', locals: { users: @users } }
      else
        format.html
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Usuário criado com sucesso!'
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find(params[:id])
    @formatted_phone_number = format_phone_number(@user.phone)
    @formatted_cpf = format_cpf(@user.cpf)
    return redirect_to users_path if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    enum_to_number

    if @user.update(user_params)
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :edit, status: :bad_request
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :cpf, :gender, :show_phone, :avatar,
                                 :profile_type)
  end

  def enum_to_number
    params[:user][:profile_type] = User::PROFILE_TYPES.values.find_index(params[:user][:profile_type])
    params[:user][:gender] = User::GENDERS.values.find_index(params[:user][:gender])
  end
end
