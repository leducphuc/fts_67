class Question < ApplicationRecord
  include CheckValidations

  has_many :choices, dependent: :destroy
  has_many :activities, as: :activable, dependent: :destroy

  scope :search, -> params {
    where("content LIKE :content_part", {subject_id: params[:subject_id],
      content_part: "%#{params[:search]}%" })
  }
end
