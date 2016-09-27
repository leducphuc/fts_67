class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def index
    @exams = Exam.unchecked
    @suggest_questions = SuggestQuestion.unapproved
  end
end
