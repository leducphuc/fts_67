class Admin::UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page], per_page: Settings.user_page
  end
end
