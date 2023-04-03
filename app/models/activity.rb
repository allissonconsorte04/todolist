class Activity < ApplicationRecord
  include Discard::Model
  belongs_to :status
  belongs_to :user
  belongs_to :category

  has_many :log_activities

  before_update :create_activity_log

  before_create :generate_code

  validates :title, :description, :category_id, :status_id, presence: true

  default_scope -> { kept }

  private

  def generate_code
    self.code = SecureRandom.hex(11) while code.blank? || Activity.exists?(code:)
  end

  def create_activity_log
    LogActivity.create!(
      activity_id: id,
      event: 'activity_updated',
      modifications: self
    )
  end
end
