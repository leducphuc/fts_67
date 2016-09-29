class SuggestQuestion < ApplicationRecord
  include CheckValidations

  belongs_to :user

  validates :user_id, presence: true

  after_update :generate_question

  enum status: [:unapproved, :rejected, :approved]

  scope :search, ->params {
    where("subject_id = :subject_id AND content LIKE :content_part
      AND status= :status", {subject_id: params[:subject_id],
      content_part: "%#{params[:search]}%", status: params[:status]})
  }

  private
  def generate_question
    if approved?
      question = Question.new subject: subject, content: content
      question.answers << answers
      question.save
    end
  end
end
