class User < ApplicationRecord
  before_save :format_cpf_phone

  validates :first_name, :last_name, :email, :phone, :cpf, :gender, :profile_type, presence: true
  validates :cpf, uniqueness: true, cpf: true
  validates :phone, uniqueness: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def format_cpf_phone
    self.cpf = cpf.gsub(/[^\d]/, '')
    self.phone = phone.gsub(/[^\d]/, '')
  end

  def generate_jwt
    payload = { user_id: id, exp: 30.days.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def self.from_jwt(token)
    payload = JWT.decode(token, Rails.application.secret_key_base).first
    user_id = payload['user_id']
    User.find_by(id: user_id)
  rescue JWT::ExpiredSignature, JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end
end
