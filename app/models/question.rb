class Question < ApplicationRecord
  belongs_to :subject

  has_many :answers, as: :answerable, dependent: :destroy
  has_many :choices, dependent: :destroy
end
