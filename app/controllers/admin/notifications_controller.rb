class Admin::NotificationsController < Admin::BaseController
    before_action :require_admin
    skip_before_action :verify_authenticity_token
    def index
        @notifications = Notification.all
    end

    def update
        @notification = Notification.find(params[:id])
        @notification.status = 1
        if @notification.save
            @count = Notification.where(status: 0).size
            render json: @count
        else
            return false
        end
    end

    def destroy
        @notification = Notification.find(params[:id])
        @notification.status = 1
        if @notification.destroy
            @count = Notification.where(status: 0).size
            render json: @count
        else
            return false
        end
    end
end
