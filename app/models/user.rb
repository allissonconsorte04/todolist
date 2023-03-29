class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  before_save :format_cpf_phone, :generate_uuid

  validates :first_name, :last_name, :email, :phone, :cpf, :gender, :profile_type, presence: true
  validates :cpf, uniqueness: true, cpf: true
  validates :phone, uniqueness: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :user_validation_tokens
  has_many :validation_tokens, through: :user_validation_tokens
  has_many :failed_login_attempts
  has_many :activities
  has_many :visitators, class_name: 'ProfileVisitor', foreign_key: :visitator_id

  attr_readonly :phone

  GENDERS = {
    MASCULINO: 'Masculino',
    FEMININO: 'Feminino',
    OUTRO: 'Outro'
  }.freeze

  PROFILE_TYPES = {
    VISITANTE: 'Visitante',
    FRONT_END: 'Front-End',
    BACK_END: 'Back-End'
  }.freeze

  enum profile_types: PROFILE_TYPES.values

  enum gender: GENDERS.values

  self.per_page = 6

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

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
