class ValidationToken < ApplicationRecord
  has_one :user_validation_token
  has_one :user, through: :user_validation_token
  has_one :validation_token_deny_list

  before_create :set_expiration_time, :generate_token
  # after_create :send_verification_sms

  def expired?
    expires_at < Time.now
  end

  def used?
    validation_token_deny_list.present?
  end

  private

  def set_expiration_time
    self.expires_at = 3.minutes.from_now
  end

  def generate_token
    self.token = Array(0..5).map { rand(0..9) }.join
  end

  def send_verification_sms
    SmsService.send_sms(user.phone, token)
  end
end
