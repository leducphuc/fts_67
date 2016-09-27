class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :choices, dependent: :destroy

  before_create :create_choice

  before_update :calculate_spent_time, if: :is_finished?
  before_update :score_calculate, if: :checked?

  enum status: [:start, :testing, :unchecked, :checked]

  accepts_nested_attributes_for :choices

  validates :subject_id, presence: true

  def remaining_time
    end_time_calculate unless end_time
    return 0 if spent_time
    end_time - Time.now
  end

  def is_finished?
    unchecked? && spent_time.nil?
  end

  private
  def create_choice
    questions = subject.questions.shuffle.take Settings.exam_questions
    questions.each do |question|
      self.choices.build question: question
    end
  end

  def end_time_calculate
    end_time = Time.now + subject.duration * 60
  end

  def calculate_spent_time
    if remaining_time >= 0
      write_attribute :spent_time, subject.duration * 60 - remaining_time
    else
      write_attribute :spent_time,  subject.duration * 60
    end
  end

  def score_calculate
    write_attribute :score, choices.correct.size
  end
end
