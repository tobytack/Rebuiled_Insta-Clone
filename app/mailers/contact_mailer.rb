class ContactMailer < ApplicationMailer
  def contact_mail(user)
    @user = user
    mail to: user.email, subject: 'Post Picture'  
  end
end