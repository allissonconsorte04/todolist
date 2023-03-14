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
end
