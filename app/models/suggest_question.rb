class SuggestQuestion < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :suggest_answers, dependent: :destroy

  accepts_nested_attributes_for :suggest_answers

  after_update :to_question

  enum status: [:unapproved, :rejected, :approved]

  private
  def to_question
    if self.approved?
      question = Question.new subject: self.subject, content: self.content
      self.suggest_answers.each do |suggest_answer|
        question.answers.build is_correct: suggest_answer.is_correct,
          content: suggest_answer.content
      end
      question.save
    end
  end
end
