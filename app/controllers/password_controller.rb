class PasswordController < ApplicationController
  skip_before_action :verify_authenticity_token

    def verify
      if verify_params[:email].blank? # check if email is present
          flash[:success] = "Email not present"
      end
      user = User.find_by(email: verify_params[:email]) # if present find user by email
        if user.present?
          user.generate_password_token! #generate pass toke
          PasswordMailer.email_verify(user).deliver_now!
          flash[:success] = "Password reset link sent on your email"
          redirect_to forget_path
        else
          flash[:danger] = "Email address not found. Please check and try again."
          redirect_to forget_path
        end
    end
    def forget
  
    end
  
    def reset
      user = User.find_by(password_reset_token: pass_params[:token])
      if user != nil 
          if user.present? 
              @user = user
          else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
          end
      else
        render json: {error: "Password reset link expire"}, status: :unprocessable_entity
      end
    end
    
    private
    def pass_params
      params.permit(:token)
    end
    # Setting up strict parameters for when we add account creation.
    def verify_params
      params.require(:password).permit(:email,:token)
    end
  end
  