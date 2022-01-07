class Api::V1::HomeController < Api::V1::BaseController
    def index
      render json: { type: "success",service: 'funnel-services', status: 200 }
    end
end
