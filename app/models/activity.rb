class Activity < ApplicationRecord
  belongs_to :status
  belongs_to :user
  belongs_to :category

  before_create :generate_code

  private

  def generate_code
    self.code = SecureRandom.hex(11) while code.blank? || Activity.exists?(code:)
  end
end
