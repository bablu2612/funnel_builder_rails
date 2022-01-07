class Api::V1::UploadsController < Api::V1::BaseController
    before_action :auth_request
    before_action :set_page, only: [:destroy]
    
    def create
        @upload = Upload.new(file_params)
        if @upload.save
            render json: {type: "success",status: 200, message: 'File uploaded successfuly'}
        else
            render json: {type: "error",status: 500, message: 'File upload failed'}
        end
    end

    def show
        @uploads = Upload.where(user_id: @@current_user.id)
        @data = @uploads.map {|upload|{:id => upload.id,:name => upload.name,:path => "#{request.base_url}#{upload.file}"}}
        render json: {type: "success",status: 200,data: @data,message: "All uploaded files of user"}  
    end

    #Delete the assset against asset id
    def destroy
        if @uploads.destroy
            render json: { type: 'success',status: 200, message: 'Asset has been deleted.' }
        end
    end

    private

    def set_page
        begin
            @uploads = Upload.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: {type: "error", message: "Asset not found with id #{params[:id]}" ,status: 404,}
        end
    end

    private

    def file_params
        params.permit(:name, :file).merge(user_id: @@current_user.id)
    end
end
