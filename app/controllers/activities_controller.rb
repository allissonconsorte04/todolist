class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show edit update destroy]
  before_action :public_activity?, only: %i[show edit update destroy]

  def index
    @activities = current_user.activities
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_activity
    @activity = Activity.find_by(code: params[:id])
  end

  def public_activity?
    return true if current_user == @activity.user
    return true if @activity.public == true

    redirect_to activities_path
  end
end
