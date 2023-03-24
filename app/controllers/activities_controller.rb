class ActivitiesController < ApplicationController
  def index
    @user = User.find_by(phone: '45999802098')
    @activities = @user.activities
    binding.pry
    
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
