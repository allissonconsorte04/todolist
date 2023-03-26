module ProfilesHelper
  def current_user?
    return false unless current_user.present?

    @user.id == @current_user.id
  end
end
