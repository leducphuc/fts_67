class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_user, :admin_user

  def home
  end
end
