class Admin::HomeController < Admin::BaseController
    before_action :require_admin
    def index

    end
end
