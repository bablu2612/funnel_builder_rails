class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy,:profile]
    before_action :require_admin
    skip_before_action :verify_authenticity_token, :only => :change_password
  
    # GET /users
    def index
      @users = User.all
    end
  
    # GET /users/1
    def show
      @user_detail = UserDetail.find_by_user_id(params[:id])
    end

    def profile
      @user_detail = UserDetail.find_by_user_id(params[:id])
    end
    # GET /users/new
    def new
      @user = User.new
    end
  
    # GET /users/1/edit
    def edit
      @user_detail = UserDetail.find_by_user_id(params[:id])
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
  
      respond_to do |format|
        if @user.save
           @user.create_user_detail!
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
      if @user.update(user_params)
         @user_detail = UserDetail.find_by(user_id: @user.id)
         @user_detail.update(user_detail_params)
         redirect_to admin_users_path
         flash[:success] = 'User has been updated successfully.'
      else
        render :users 
        flash[:danger] = 'User updation failed.'
      end
    end

    def new_pass
    end

    def change_password
      user = User.find(current_admin.id)
      if user && user.authenticate(password_params[:old_password])
          if password_params[:password] == password_params[:password_confirmation]
              if user.update(password: password_params[:password])
                redirect_to admin_root_path
                flash[:success] = 'Password has been successfully updated.'
              else
                flash[:danger] = "Password updation failed. Please try again later."
                redirect_to admin_new_pass_path
              end
          else
            flash[:danger] = "Password updation failed. Please try again later."
            redirect_to admin_new_pass_path
          end
      else
        redirect_to admin_new_pass_path
        flash[:danger] = "Password updation failed. Please try again later."
      end
    end
  
    # DELETE /users/1
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User has been successfully destroyed.' }
        format.json { head :no_content }
      end
    end
    
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
      
      # Never trust parameters from the scary internet, only allow the white list through.
      def password_params
        params.require(:password).permit(:old_password,:password, :password_confirmation)
      end

      def user_params
        params.require(:user).permit(:id,:f_name, :l_name, :email, :password, :password_confirmation)
      end
      
      def user_detail_params
        params.require(:user).permit(:address, :phone, :city, :province, :zipcode, :country)
      end
  end
  