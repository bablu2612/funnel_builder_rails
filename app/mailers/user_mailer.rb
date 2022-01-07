class UserMailer < ApplicationMailer
    default :from => "testaccntof8@gmail.com"

    def registration_confirmation(user)
       @user = user
       mail(:to => "#{@user.f_name} <#{@user.email}>", :subject => "Registration Confirmation")
    end
end
