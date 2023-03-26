module UsersHelper
  def visit_count(user)
    ProfileVisitor.total_visits_by_visitee(user)
  end
end
