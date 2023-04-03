class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show update edit destroy]
  before_action :public_activity?, only: %i[show edit destroy]

  def index
    @activities = current_user.activities.order(:id)

    if params[:query].present?
      @activities = @activities.where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{params[:query].downcase}%",
                                      "%#{params[:query].downcase}%")
    end
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'search'
        format.html { render partial: 'card_index', locals: { activities: @activities } }
      else
        format.html
      end
    end
  end

  def public_index
    redirect_to activities_path if current_user.uuid == params[:user_uuid]
    @activities = Activity.joins(:user).where(public: true, users: { uuid: params[:user_uuid] })
  end

  def show; end

  def new
    @activity = current_user.activities.new
  end

  def create
    @activity = current_user.activities.new(activity_params)
    if @activity.save
      redirect_to activities_path
    else
      flash.now[:error] = @activity.errors.full_messages.to_sentence
      render :new, status: :bad_request
    end
  end

  def edit; end

  def update
    if @activity.update(activity_params)
      redirect_to activities_path, notice: 'Atividade atualizada com sucesso'
    else
      flash.now[:error] = @activity.errors.full_messages.to_sentence
      render :edit, status: :bad_request
    end
  end

  def destroy
    @activity.discard
    redirect_to activities_path, notice: 'Atividade deletada com sucesso'
  end

  private

  def activity_params
    params.require(:activity).permit(:code, :title, :description, :category_id, :status_id, :public)
  end

  def set_activity
    @activity = Activity.find_by(code: params[:code])
  end

  def public_activity?
    return true if current_user == @activity.user
    return true if @activity[:public] == true

    redirect_to activities_path
  end

  def set_params; end
end
