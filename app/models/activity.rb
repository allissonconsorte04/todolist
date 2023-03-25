class Activity < ApplicationRecord
  include Discard::Model
  belongs_to :status
  belongs_to :user
  belongs_to :category

  before_create :generate_code

  default_scope -> { kept }

  private

  def generate_code
    self.code = SecureRandom.hex(11) while code.blank? || Activity.exists?(code:)
  end
end
