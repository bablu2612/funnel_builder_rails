class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
    if product.nil?
     redirect_to root_path
    end
    Stripe.api_key = 'sk_test_BMHo4P2D81el6tcJ88K8ureu005fondgSO'

    @session = Stripe::Checkout::Session.create(
         billing_address_collection: 'required',
      shipping_address_collection: {
        allowed_countries: ['US', 'CA','IN'],
      },
        
      payment_method_types:['card'],
      line_items:[{name: product.name,
      description: product.description,
      amount: product.price_cents,
      currency: 'usd',
      quantity: 1
      
      }],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url:  checkout_cancel_url
    )
    respond_to do |format|
          format.js
    end


  end


  def cancel;
  end
  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

#  @payment_intent= ActiveSupport::JSON.decode(@payment_intent)
#  @payment_intent= ActiveSupport::JSON.encode(@payment_intent) 
#  @payment_intent= JSON.parse(@payment_intent)

  @bil_city=@payment_intent['charges']['data'][0]['billing_details']['address']['city'] 
  @bil_state=@payment_intent['charges']['data'][0]['billing_details']['address']['state'] 
  @bil_country= @payment_intent['charges']['data'][0]['billing_details']['address']['country']
  @bil_line1=@payment_intent['charges']['data'][0]['billing_details']['address']['line1'] 
  @bil_line2=@payment_intent['charges']['data'][0]['billing_details']['address']['line2'] 
  @bil_pcode=@payment_intent['charges']['data'][0]['billing_details']['address']['postal_code'] 

  # @bil_name=@payment_intent['charges']['data'][0]['billing_details']['name'] 
  # @bil_email=@payment_intent['charges']['data'][0]['billing_details']['email'] 

      @bil_address=@bil_line1+','+@bil_line2+','+@bil_pcode+','+@bil_city+','+@bil_state+','+@bil_country

      @ship_line1=@session.shipping.address.line1
      @ship_line2=@session.shipping.address.line2
      @city=@session.shipping.address.city
      @state=@session.shipping.address.state
      @country=@session.shipping.address.country
      @pin_code=@session.shipping.address.postal_code

      @ship_address=@ship_line1+','+@ship_line2+','+@pin_code+','+@city+','+@state+','+@country
      @data =Order.new(name: @session.shipping.name, billing_add:@bil_address, shiping_add:@ship_address)
          @data.save!
  end
   

end
