class SuggestQuestion < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :answers, as: :answerable, dependent: :destroy

  accepts_nested_attributes_for :answers

  after_update :generate_question

  enum status: [:unapproved, :rejected, :approved]

  private
  def generate_question
    if approved?
      question = Question.new subject: subject, content: content
      question.answers << answers
      question.save
    end
  end
end
