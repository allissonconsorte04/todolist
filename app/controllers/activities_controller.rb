class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show update edit destroy]
  before_action :public_activity?, only: %i[show edit destroy]

  def index
    @activities = current_user.activities.order(:id)
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
    @activity = Activity.find_by(code: activity_params[:code])

    if @activity.update(activity_params)
      redirect_to activities_path, notice: 'Atividade atualizada com sucesso'
    else
      flash.now[:error] = @activity.errors.full_messages.to_sentence
      render partial: 'activity', status: :bad_request
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
