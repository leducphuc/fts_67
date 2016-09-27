class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_subjects

  def index
    @exams = Exam.unchecked
    @suggest_questions = SuggestQuestion.unapproved
    @suggest_question = current_user.suggest_questions.new
  end
end
