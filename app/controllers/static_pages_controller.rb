class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @exams = current_user.exams.order updated_at: :desc
    @suggest_questions = current_user.suggest_questions.order updated_at: :desc
  end
end
