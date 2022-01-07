class PasswordMailer < ApplicationMailer
default :from => "testaccntof8@gmail.com"

   def email_verify(user)
      @user = user
      mail(:to => "#{@user.f_name} <#{@user.email}>", :subject => "Password reset confirmation")
   end
end
