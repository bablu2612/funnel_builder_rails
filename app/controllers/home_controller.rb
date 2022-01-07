class HomeController < ApplicationController
  def index

    if session[:user_id].present?
    @user = User.find(session[:user_id])
    end

  end

  def payment_gateway

    @user = User.find(session[:user_id])
    render :payment_gateway


  end
end
