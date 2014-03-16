class UserMailer < ActionMailer::Base
  default from: "<PreventIT> welcome@PreventITHealth.com"
  
  def activation_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token)
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Welcome to PreventIT')
  end
end
