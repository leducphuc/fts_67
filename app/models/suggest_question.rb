class SuggestQuestion < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :suggest_answers, dependent: :destroy
end
