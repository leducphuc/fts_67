class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_question, only: :destroy

  def destroy
    if @question.destroy
      flash[:success] = t "question.destroy_success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t "delete.danger"
      redirect_to root_url
    end
  end

  private
  def find_question
    @question = Question.find_by id: params[:id]
    if @question.nil?
      flash[:danger] = t "question.nil"
      redirect_to root_url
    end
  end
end
