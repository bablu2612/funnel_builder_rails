class Api::V1::UserDetailsController < Api::V1::BaseController
  before_action :auth_request,  only: [:index,:show, :update]
  before_action :set_user_detail, only: [:show,:edit, :update, :destroy]
 

  # GET /user_details
  def index
    @user_details = UserDetail.all

    #render json: @user_details
  end
  
  def edit
    user_detail = {id: @user_detail.id,user_id: @user_detail.user_id,phone: @user_detail.phone,address: @user_detail.address,city: @user_detail.city,province: @user_detail.province,zipcode: @user_detail.zipcode,country: @user_detail.country}
    render json:  {type: "success",data: user_detail,status: 200,message: "billing information"}
  end
  # GET /user_details/1
  
  def show
     user_detail = {id: @user_detail.id,user_id: @user_detail.user_id,phone: @user_detail.phone,address: @user_detail.address,city: @user_detail.city,province: @user_detail.province,zipcode: @user_detail.zipcode,country: @user_detail.country}
     render json:  {type: "success",data: user_detail,status: 200,message: "billing information"}
    #render json: @user_detail
  end

  # POST /user_details
  def create
    @user_detail = UserDetail.new(user_detail_params)
    if @user_detail.save
      render json: @user_detail, status: :created, location: @user_detail
    else
      render json: @user_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_details/1
  def update
    if @user_detail.update(user_detail_params)
      render json:  {type: "success",data: "",status: 200,message: "billing information updated"}
    elsif @user_detail.errors.any?
      render json: {type: "error",status: 400, messgae: @user.errors.messages}
    else
      render json: {type: "error",status: 500,message: "Internal server error"}
    end
  end

  # DELETE /user_details/1
  def destroy
    @user_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_detail
      begin
        @user_detail = UserDetail.find_by(user_id: params[:id])
      rescue ActiveRecord::RecordNotFound
          render json: {type: "error", message: "Not Found" ,status: 404,}
      end
    end

    # Only allow a trusted parameter "white list" through.
    private
  
    # Setting up strict parameters for when we add account creation.
    def user_detail_params
      params.require(:user_detail).permit(:phone ,:address, :city, :province, :zipcode,:country)
    end
end
