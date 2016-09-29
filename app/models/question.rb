class Question < ApplicationRecord
  include CheckValidations

  has_many :choices, dependent: :destroy
  has_many :activities, as: :activable, dependent: :destroy
end
