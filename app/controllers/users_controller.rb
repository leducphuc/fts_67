class UsersController < ApplicationController
  before_action :find_user, only: :show
  
  def show
  end

  private
  def find_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "user.user_nil"
      redirect_to root_path
    end
  end
end
