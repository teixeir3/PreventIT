class UserMailer < ActionMailer::Base
  default from: "<PreventIT> welcome@PreventITHealth.com"
  
  def activation_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token)
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Welcome to PreventIT')
  end
  
  def password_reset_email(user)
    @user = user
    @url = password_reset_users_url(reset_token: @user.activation_token)
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'PreventIT Password Reset')
  end
end
