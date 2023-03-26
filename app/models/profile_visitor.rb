class ProfileVisitor < ApplicationRecord
  belongs_to :visitee, class_name: 'User'
  belongs_to :visitator, class_name: 'User'

  scope :visits_in_last_five_minutes, lambda { |visitator, visitee|
    where(visitator:, visitee:, created_at: 5.minutes.ago..DateTime.now)
  }

  scope :total_visits_by_visitee, ->(visitee) { where(visitee:).count }

  def self.count_visit?(visitator, visitee)
    return false if visitator.blank?

    visits_in_last_five_minutes(visitator, visitee).blank?
  end
end
