class StripeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def connect
    response = HTTParty.post("https://connect.stripe.com/oauth/token",
    query: {
        client_secret: "sk_test_BMHo4P2D81el6tcJ88K8ureu005fondgSO",
        code: params[:code],
        grant_type: "authorization_code"
      }
    )

    if response.parsed_response.key?("error")
      
      redirect_to payment_gateway_path,
      
      notice: 'error!'

    else
      stripe_user_id = response.parsed_response["stripe_user_id"]

      @data= User.find(session[:user_id]).update_column(:stripe_user_id , stripe_user_id)

      redirect_to payment_gateway_path,

      notice: 'User successfully connected with Stripe!'
    end
  end
  
def disconnect

  Stripe.api_key = 'sk_test_BMHo4P2D81el6tcJ88K8ureu005fondgSO'
  session[:stripe_user_id] = ''
  @user = User.find(session[:user_id])

  session[:stripe_user_id] = @user.stripe_user_id

  Stripe::OAuth.deauthorize({
    client_id: 'ca_HDV3r9d97gQsUnB6eHngCQ9KmAxQkXpU',
    stripe_user_id: session[:stripe_user_id],
  })
  @data = User.find(session[:user_id]).update_column(:stripe_user_id , nil)

  redirect_to payment_gateway_path,

  notice: 'User successfully dis_connected with Stripe!'

end

def payment_gateway

  @user = User.find(session[:user_id])
  render :payment_gateway


end

def save_card
  @flag=""
  if session[:user_id].present?
    begin
    @user = Card.find_by(user_id:session[:user_id])
    @customer = Stripe::PaymentMethod.list({
        customer: @user.customer_id,
        type: 'card'
      })
    rescue
      @flag="error";

    end

if @flag == ""

if @user.last_digit.present?
  @last4=@user.last_digit
else
  @last4 = ""
   
  end  
end


  end
  render :save_card


end

def carddetailsave
  @error = nil
  Stripe.api_key = 'sk_test_BMHo4P2D81el6tcJ88K8ureu005fondgSO'
  @data_ab = params[:id]
  @last4 = params[:last4]
  @tok_id = params[:tok_id]
  @usr_id = session[:user_id]
  @user = Card.find_by(user_id:session[:user_id]) #update card

begin
@user_card_id = @user.id
rescue
@error = "error"
end
@user_tb = User.find(session[:user_id])

if @error.nil?

  # Stripe::Customer.delete(@user.customer_id)
  @customer = Stripe::Customer.update(@user.customer_id, {
    source: @tok_id,
})
  @cus_id=@customer['id']
  Card.update(user_id:@usr_id, customer_id:@cus_id, last_digit:@last4)

else

  @customer = Stripe::Customer.create({
    description: 'Stripe account',
    email: "test@mail.com",

    source: @tok_id
  })
  @cus_id=@customer['id']
  

@data = Card.new(user_id:@usr_id, customer_id:@cus_id, last_digit:@last4)
@data.save!
end

render json: @cus_id

end

def deletecard

  @user = Card.find_by(user_id:session[:user_id]) #update card

  Stripe::Customer.delete(@user.customer_id)
  @user.destroy
  redirect_to request.referer,

  notice: 'sucessfully deleted'
  
end

end