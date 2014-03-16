class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def activation_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token)
    mail(to: user.email, subject: 'PreventIT: Activation Email')
  end
end
