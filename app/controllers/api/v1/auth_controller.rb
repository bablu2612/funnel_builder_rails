class Api::V1::AuthController < Api::V1::BaseController
    before_action :auth_request,  only: [:logout]

    def login
        @user = User.find_by_email(login_params[:email])
        if @user != nil
            if @user && @user.authenticate(login_params[:password])
                #if @user.email_confirmed
                if @user.token?
                    if @user.duplicate_login_token?
                        @token = @user.duplicate_login_token
                        render json: { type: "success",status: 200,data:{token: @token,user_id: @user.id,f_name: @user.f_name,l_name: @user.l_name,email: @user.email,image: @user.image? ? "#{request.base_url}#{@user.image}" : nil,:phone => @user.user_detail.phone,:address => @user.user_detail.address,:city => @user.user_detail.city,:province => @user.user_detail.address,:country => @user.user_detail.country,:zipcode => @user.user_detail.zipcode}, message: "You are currently Logged-in as #{@user.f_name}" }
                    else
                        @token = JsonWebToken.encode({user: @user})
                        @user.update(token: @token)
                        @user.update(duplicate_login_token: @token)
                        render json: { type: "success",status: 200,data:{token: @token,user_id: @user.id,f_name: @user.f_name,l_name: @user.l_name,email: @user.email,image: @user.image? ? "#{request.base_url}#{@user.image}" : nil,:phone => @user.user_detail.phone,:address => @user.user_detail.address,:city => @user.user_detail.city,:province => @user.user_detail.address,:country => @user.user_detail.country,:zipcode => @user.user_detail.zipcode}, message: "You are currently Logged-in as #{@user.f_name}" }
                    end
                else
                    @token = JsonWebToken.encode({user: @user})
                    @user.update(token: @token)
                    @user.update(duplicate_login_token: @token)
                    render json: { type: "success",status: 200,data:{token: @token,user_id: @user.id,f_name: @user.f_name,l_name: @user.l_name,email: @user.email,image: @user.image? ? "#{request.base_url}#{@user.image}" : nil,:phone => @user.user_detail.phone,:address => @user.user_detail.address,:city => @user.user_detail.city,:province => @user.user_detail.address,:country => @user.user_detail.country,:zipcode => @user.user_detail.zipcode}, message: "You are currently Logged-in as #{@user.f_name}" }
                end
                # else 
                #     render json: { type : "error",status: 401, message: "Please verify email" }
                # end
            else
                render json: { type: "error",status: 500, message: "Password Invaild" }
            end 
        else
            render json: { type: "error",status: 404, message: "Email address Invaild" }
        end
    end

    # def logout
    #     @user = User.find(@@current_user.id)
    #      if @user.update(token:"")
    #         render json: { type: "success",status: 200, message: "You are currently logged out" }
    #     else
    #         render json: { type: "error",status: 500, message: "Invaild email or password " }
    #     end     
    # end

    private
  

    def login_params
        params.permit(:email,:password)
    end
end
