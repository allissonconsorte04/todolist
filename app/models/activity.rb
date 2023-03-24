class Activity < ApplicationRecord
  belongs_to :status
  has_one :user

  before_create :generate_code

  private

  def generate_code
    while self.code.blank? || Activity.exists?(code: self.code)
      self.code = SecureRandom.hex(11)
    end
  end
end
