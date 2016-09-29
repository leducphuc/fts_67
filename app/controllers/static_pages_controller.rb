class StaticPagesController < ApplicationController
  before_action :logged_in_user
  before_action :load_subjects

  def index
    @exams = current_user.exams.includes(:subject).order updated_at: :desc
    @exam = Exam.new
    @suggest_questions = current_user.suggest_questions.includes(:subject)
      .order updated_at: :desc
    @suggest_question = current_user.suggest_questions.new
  end
end
