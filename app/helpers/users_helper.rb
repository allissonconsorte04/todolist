module UsersHelper
  def visit_count(user)
    ProfileVisitor.total_visits_by_visitee(user)
  end

  def profile_type_options
    User::PROFILE_TYPES.invert.to_a
  end
end
