class Admin::SuggestQuestionsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_suggest_question, except: :index
  before_action :load_subjects, only: :index
  before_action :load_statuses, only: :index

  def index
    @suggest_questions = if params[:find]
      SuggestQuestion.search(search_params).includes(:subject)
        .paginate page: params[:page], per_page: Settings.suggest_questions
    else
      SuggestQuestion.all.includes(:subject)
    end
  end

  def show
  end

  def update
    if @suggest_question.update_attributes status: params[:status]
      flash.now[:success] = t "suggest_question.update_success"
    else
      flash.now[:danger] = t "suggest_question.update_error"
    end
    redirect_to admin_suggest_questions_path
  end

  def destroy
    if @suggest_question.destroy
      flash.now[:success] = t "suggest_question.update_success"
    else
      flash.now[:danger] = t "suggest_question.update_error"
    end
    redirect_to admin_suggest_questions_path
  end

  private
  def find_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    if @suggest_question.nil?
      flash[:danger] = t "find_suggest.danger"
      redirect_to admin_suggest_questions_path
    end
  end

  def search_params
    params.permit :subject_id, :search, :status
  end

  def load_statuses
    @status_select =
      SuggestQuestion.statuses.map{|key, value|
      [t("suggest_question_status.#{key}"), value]}
  end
end
