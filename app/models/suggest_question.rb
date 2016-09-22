class SuggestQuestion < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :answers, as: :answerable, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true
  validate :answers_size
  validate :check_correct_answer

  after_update :generate_question

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answers| answers[:content].blank?}

  private
  def generate_question
    if approved?
      question = Question.new subject: subject, content: content
      question.answers << answers
      question.save
    end
  end

  def answers_size
    errors.add :question, I18n.t(:answer_size) if answers.size < 2
  end

  def check_correct_answer
    correct_answer = answers.select {|answer| answer.is_correct?}
    errors.add :correct_answer,
      I18n.t("answer.must_check") if correct_answer.empty?
  end
end
