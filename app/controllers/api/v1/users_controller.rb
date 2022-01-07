class Api::V1::UsersController < Api::V1::BaseController
  before_action :auth_request,  only: [:index,:current,:show, :update,:change_password]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :set_user, only: [:show,:edit,  :destroy]
  #skip_before_action :verify_authenticity_token
  # Should work if the current_user is authenticated.
  def index
    @users = User.all
    @data = @users.map do |user|
      {:user_id => user.id,
      :first_name => user.f_name,
      :last_name => user.l_name,
      :email => user.email,
      :image => user.image? ? "#{request.base_url}#{user.image}" : nil,
      :phone => user.user_detail.phone,
      :address => user.user_detail.address,
      :city => user.user_detail.city,
      :province => user.user_detail.address,
      :country => user.user_detail.country,
      :zipcode => user.user_detail.zipcode
    }
    end
    render json: {type: "success",data: @data,status: 200,message: "All users"}
  end
  def show
     user = {user_id: @user.id,f_name: @user.f_name,l_name: @user.l_name,email: @user.email,:image => @user.image? ? "#{request.base_url}#{@user.image}" : nil,:phone => @user.user_detail.phone,:address => @user.user_detail.address,:city => @user.user_detail.city,:province => @user.user_detail.address,:country => @user.user_detail.country,:zipcode => @user.user_detail.zipcode}
     render json:  {type: "success",data: user,status: 200,message: ""}
    #render :json => { :sucess => true,:user => @user.to_json(:only =>[ :id,:f_name,:l_name,:email]) }
    
  end
  def edit
    user = {id: @user.id,f_name: @user.f_name,l_name: @user.l_name,email: @user.email}
     render json:  {type: "success",data:user,status: 200,message: ""}
  end

  def create
      @user = User.new(f_name: user_params[:f_name],l_name: user_params[:l_name],email: user_params[:email],password: user_params[:password],image: user_params[:image])
      if @user.save
          @user.create_user_detail!
          #UserMailer.registration_confirmation(@user).deliver
          render json: {type: "success",status: 200, message: 'User was created.'}
      elsif @user.errors.any?
          render json: {type: "error",status: 400, message: @user.errors.messages}
      else
          render json: {type: "error",status: 400, message: 'error.'}
      end
  end
  
  # Method to update a specific user. User will need to be authorized.
  def update
    @user = User.find(@@current_user.id)
    if @user.update(user_params)
        @user_detail = UserDetail.find_by(user_id: @user.id)
        if @user_detail.update(user_details_params)
            render json: {type: "success",status: 200, message: 'User profile updated sccessfully.'}
        elsif @user_detail.errors.any?
          render json: {type: "error",status: 400, message: @user_detail.errors.messages}
        else
          render json: {type: "error",status: 400, message: 'error.'}
        end
    elsif @user.errors.any?
        render json: {type: "error",status: 400, message: @user.errors.messages}
    else
        render json: {type: "error",status: 400, message: 'error.'}
    end
  end
  
  def change_password
    user = User.find(@@current_user.id)
    if user && user.authenticate(user_params[:old_password])
      if user.update(password: user_params[:password])
        render json: { type: "success" , status: 200, message: 'Password changed' } 
      elsif @user.errors.any?
        render json: {type: "error",status: 400, message: @user.errors.messages}
      else
        render json: {type: "error",status: 500, message: 'Internal server error.'}
      end
    else
      render json: { type: "error" , status: 400, message: 'Old password not match' } 
    end
  end
  
  def verify
    if user_params[:email].blank? # check if email is present
        flash[:success] = "Email not present"
    end
    user = User.find_by(email: user_params[:email]) # if present find user by email
      if user.present?
        user.generate_password_token! #generate pass toke
        PasswordMailer.email_verify(user).deliver_now!
        render json: { type: "success" , status: 200, message: "Password reset link sent on your email" }
      else
        render json: { type: "error" , status: 400, message: "Email address not found. Please check and try again." } 
      end   
  end        

  # Method to delete a user, this method is only for admin accounts.
  def destroy
    if @user.destroy
      render json: { status: 200, message: 'User has been deleted.' }
    end
  end

  def set_user
    begin
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {type: "error", message: "Not Found" ,status: 404}
    end
  end
  private
  
  # Setting up strict parameters for when we add account creation.
  def user_params
    params.permit(:f_name,:l_name, :email,:old_password, :password, :password_confirmation,:image)
  end
  def user_details_params
    params.permit(:province,:phone,:city,:address,:zipcode,:country)
  end
end