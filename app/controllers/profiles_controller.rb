class ProfilesController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!

  def show
    @user = User.find_by(uuid: params[:uuid])
    @formatted_phone_number = format_phone_number(@user.phone)
    @formatted_cpf = format_cpf(@user.cpf)
    count_visit
  end

  private

  def count_visit
    return unless ProfileVisitor.count_visit?(current_user, @user)
    return if current_user == @user

    ProfileVisitor.create(visitee: @user, visitator: current_user)
  end
end
