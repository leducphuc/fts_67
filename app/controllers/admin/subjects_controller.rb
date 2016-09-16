class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user, :admin_user
  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subject.success"
      redirect_to @subject
    else
      flash[:danger] = t "subject.fail"
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :duration, :description
  end
end
