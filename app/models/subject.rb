class Subject < ApplicationRecord
  attr_accessor :actor_id

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy
  has_many :activities, as: :activable, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: {minimum: 6}
  validates :duration, numericality: true

  after_create {ActivityGenerator.created self}
  after_update {ActivityGenerator.updated self}
  after_destroy {ActivityGenerator.deleted self}

  class << self
    def search(params)
      if params
        where("name LIKE :name_part AND description LIKE :description_part AND duration = :status",
          {name_part: params[:name],
          description_part: "%#{params[:description]}%",
          duration: params[:duration]})
      else
        all
      end
    end
  end
end
