class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Sending email with password reset instructions."  
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    
    if @user.password_reset_sent_at < 24.hours.ago
      flash.now[:errors] = ["Password reset has expired."]
      render new_password_reset_path
    end
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    
    if @user.password_reset_sent_at < 24.hours.ago
      flash.now[:errors] = ["Password reset has expired."]
      render new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      sign_in(@user)
      flash[:errors] = ["Password has been reset!"]
      redirect_to user_url(@user), :notice => "Password has been reset!"
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end
end
