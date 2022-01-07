class Admin::BaseController < ApplicationController
    layout "admin"
    helper_method :current_admin, :admin_logged_in?,:flash_class
  
  def current_admin
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_logged_in?
    !!(current_user && current_user.role == "admin") 
  end

  def require_admin
    if !admin_logged_in?
      flash[:danger] = "You must be logged in as admin to perform that action"
      redirect_to admin_login_path
    end
  end
  
end
