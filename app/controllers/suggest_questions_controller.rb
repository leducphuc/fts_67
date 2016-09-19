class SuggestQuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :load_subjects, only: [:new, :create]

  def new
    @suggest_question = SuggestQuestion.new
  end

  def create
    @suggest_question =
      current_user.suggest_questions.new suggest_question_params
    if @suggest_question.save
      flash[:success] = t "suggest_question.create_success"
      redirect_to root_url
    else
      load_subjects
      render :new
    end
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :id, :content,:subject_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
