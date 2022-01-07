class Api::V1::BaseController < ActionController::API
    include ActionController::Helpers
    helper_method :auth_request

    def auth_request
        header = request.headers['Authorization']
        if !header.blank?
          begin
            @user = User.find_by(token: header)
            if @user.nil?
                render json: { type: "error",status: 404,message: "User unauthorized" },status: 404
            else
                @@current_user = @user
            end
          rescue ActiveRecord::RecordNotFound => e
            render json: {status: "401", errors: e.message }, status: :unauthorized
          rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
          end
        else
          render json: { type: "error",status: 404,message: "Authentication token null" },status: 404
        end
    end

end


