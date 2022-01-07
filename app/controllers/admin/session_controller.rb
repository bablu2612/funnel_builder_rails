class Admin::SessionController < Admin::BaseController
    before_action :require_admin, only: [:logout]
    skip_before_action :verify_authenticity_token, :only => :login
  def new
  end

  def login
    @user = User.find_by_email(session_params[:email]) 
      if @user && @user.authenticate(session_params[:password])
          if @user.role == "admin"
              # if user.email_confirmed
              flash[:success] = "You are logged in"
              session[:user_id] = @user.id
              redirect_to admin_root_path
              #format.json { render :show, status: :created, location: @user_detail }
              # else
              #   render json: "first confirm email"
              # end
          else
              redirect_to admin_root_path
              flash[:danger] = "User must be admin"
          end
      else
          render :new
          flash[:danger] = "Whoops!  You have entered an  incorrect username or Password"
      end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to admin_root_path
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
