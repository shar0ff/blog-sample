class ApplicationController < ActionController::Base
  include Pagy::Backend

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end
end
