class DashboardController < ApplicationController
  def index

    if session[:user_id].present?
    @user1 = User.find(session[:user_id])
    end
    #@user = Funnel.find_by(user_id:session[:user_id]).All
    @funnels = Funnel.where(user_id:session[:user_id])


    
   

    render :funnel_list
  end
def show_page

  @pages = Page.where(funnel_id: params[:id])
  render :show_page

end
 
end
