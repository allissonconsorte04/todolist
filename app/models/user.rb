class User < ApplicationRecord
  before_save :format_cpf_phone

  validates :first_name, :last_name, :email, :phone, :cpf, :gender, presence: true
  validates :cpf, uniqueness: true, cpf: true
  validates :phone, uniqueness: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :user_validation_tokens
  has_many :validation_tokens, through: :user_validation_tokens
  has_many :failed_login_attempts

  def format_cpf_phone
    self.cpf = cpf.gsub(/[^\d]/, '')
    self.phone = phone.gsub(/[^\d]/, '')
  end

  def valid_token?(received_token)
    return false if current_token.token != received_token
    return false if current_token.expired? || current_token.used?

    true
  end

  def blocked?
    return false unless blocked_at.present?

    (Time.now - blocked_at) < 3.minutes
  end

  def max_attempts_reached?
    failed_login_attempts.where(created_at: 3.minutes.ago..DateTime.now).count >= 3
  end

  private

  def current_token
    validation_tokens.last
  end
end
