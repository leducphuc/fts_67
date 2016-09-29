class Subject < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy
  has_many :activities, as: :activable, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: {minimum: 6}
  validates :duration, numericality: true

  scope :search, -> params {
    where("name LIKE :name_part", {name_part: "%#{params[:search]}%"})
  }
end
