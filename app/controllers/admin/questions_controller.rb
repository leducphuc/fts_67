class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_question, only: [:destroy, :show]
  before_action :load_subjects, only: [:new, :create]

  def show
  end

  def new
    @question = Question.new
    Settings.number_of_answers.times {@question.answers.build}
  end

  def destroy
    if @question.destroy
      flash[:success] = t "question.destroy_success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t "delete.danger"
      redirect_to root_url
    end
  end

  def create
    @question = Question.new question_params
    if @question.save
      @subject = @question.subject
      flash[:success] = t "question.created_success"
      redirect_to admin_subject_path @subject
    else
      load_subjects
      flash[:danger] = t "question.created_fail"
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :content, :subject_id,
      answers_attributes: [:content, :is_correct, :_destroy]
  end

  def find_question
    @question = Question.find_by id: params[:id]
    if @question.nil?
      flash[:danger] = t "question.nil"
      redirect_to root_url
    end
  end
end
