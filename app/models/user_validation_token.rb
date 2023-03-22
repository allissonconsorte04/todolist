class UserValidationToken < ApplicationRecord
  belongs_to :user
  belongs_to :validation_token

  validates :validation_token_id, uniqueness: { scope: :user_id }
end
