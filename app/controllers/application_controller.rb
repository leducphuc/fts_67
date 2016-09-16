class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "logged_in.danger"
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end
end
