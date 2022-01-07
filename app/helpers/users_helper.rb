module UsersHelper
    def stripe_button_link
        stripe_url = "https://connect.stripe.com/oauth/authorize"
        redirect_uri = 'http://dev7.csdevhub.com/stripe/connect'
        client_id = "ca_HDV3r9d97gQsUnB6eHngCQ9KmAxQkXpU"
        
        "#{stripe_url}?response_type=code&client_id=#{client_id}&scope=read_write&redirect_uri=#{redirect_uri}"
    
      end
end
