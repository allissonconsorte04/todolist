class LoginToken < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true

  attribute :login_count, :integer, default: 0

  before_create :set_expiration_time, :generate_token

  def expired?
    expires_at < Time.now
  end

  private

  def set_expiration_time
    self.expires_at = 3.minutes.from_now
  end

  def generate_token
    self.login_token = rand(10**6).to_s.rjust(6, '0')
  end
end
