class SessionsController < ApplicationController
  before_filter :require_signed_out!, :only => [:new, :create]
  before_filter :require_signed_in!, :only => [:destroy]

  def new
    render :new
  end

  def create
    google_data = request.env["omniauth.auth"]

    if google_data
      @user = User.find_by_provider_and_uid(google_data["provider"], google_data["uid"])

      unless @user
        @user = create_from_google_data(google_data)
      end
    else
      @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])
    end

    if @user
      sign_in(@user)
      if @user.is_doctor
        redirect_to doctor_url(@user)
      else
        redirect_to user_url(@user)
      end
    else
      flash.now[:errors] = ["Incorrect credentials"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

end
