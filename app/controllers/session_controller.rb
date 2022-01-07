class SessionController < ApplicationController
  before_action :require_user, only: [:logout]
  skip_before_action :verify_authenticity_token
  def new
    if session[:user_id]
      redirect_to root_path
    end
  end

  def login
    @user = User.find_by_email(session_params[:email]) 
    if @user && @user.authenticate(session_params[:password])
      # if user.email_confirmed
        session[:user_id] = @user.id
        flash[:success] = "You have logged in"
        redirect_to root_path
      # else
      #   flash[:success] = "First confirm your email"
          #redirect_to root_path
      # end
    else
      render :new
      #format.json { render json: @user_detail.errors, status: :unprocessable_entity }
    end
     
  end

  def logout
    session[:user_id] = nil
    flash[:danger] = "You have logged out"
    redirect_to root_path
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
