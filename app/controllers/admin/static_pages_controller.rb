class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_user, :veriry_admin

  def home
  end
end
