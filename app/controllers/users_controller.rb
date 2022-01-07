class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:reset_password]
  before_action :require_user, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token


  # GET /users
  def index
     
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user_detail = UserDetail.find_by_user_id(@user)
  end
  
  def block

   @data= User.find(params[:id]).update_column(:block_status , params[:block_status])
   @data= User.find(params[:id])
   render json: @data
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.create_user_detail!
        #UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "User has been successfully created."
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user_detail = UserDetail.find_by_user_id(@user)
        @user_detail.update(user_detail_params)
        format.html { redirect_to @user, notice: 'User has been successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset_password
    if @user.update(user_params)
      render json: "password reset successfull"
    else
      render json: @user.errors
    end
  end
  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #confirm email with token
  def confirm_email
    user = User.find_by_confirm_token(token_params[:token])
    if user
      user.email_activate
      redirect_to confirm_path
    else
      render json: "Sorry. User does not exist"
    end
  end

  #after confirm email show confirmation display
  def confirm_msg

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id,:f_name, :l_name, :email, :password, :password_confirmation)
    end
    
    def user_detail_params
      params.require(:user).permit(:address, :phone, :city, :province, :zipcode, :country)
    end
end
