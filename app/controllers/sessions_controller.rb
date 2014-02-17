class SessionsController < ApplicationController
  before_filter :require_signed_out!, :only => [:new, :create]
  before_filter :require_signed_in!, :only => [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:email],
    params[:user][:password])

    if @user
      sign_in(@user)
      redirect_to user_url(@user)
    else
      render :json => "Incorrect credentials"
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

end
