class User < ApplicationRecord
  has_many :activitys, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy
end
