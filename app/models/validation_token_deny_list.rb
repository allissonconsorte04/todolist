class ValidationTokenDenyList < ApplicationRecord
  belongs_to :validation_token

  validates :validation_token_id, uniqueness: true
end
