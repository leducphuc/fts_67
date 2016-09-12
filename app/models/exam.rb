class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :choices, dependent: :destroy
end
