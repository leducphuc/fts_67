class Admin::ActivitiesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @activities = Activity.order("created_at DESC").paginate params[:page],
      perpage: Settings.activities
  end
end
