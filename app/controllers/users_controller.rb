class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]

  def index
    @users = User.all.order(:id)

    if params[:query].present?
      @users = @users.where('LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?', "%#{params[:query].downcase}%",
                            "%#{params[:query].downcase}%")
    end

    @users = @users.where(profile_type: User.profile_types[params[:profile_type]]) if params[:profile_type].present?

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
      redirect_to users_path
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    enum_to_number
    binding.pry

    if @user.update(user_params)
      redirect_to users_path
    else
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
