class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def sign_out
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

  def require_signed_out!
    if signed_in? && current_user.is_doctor
      redirect_to doctor_url(current_user)
    elsif signed_in?
      redirect_to user_url(current_user)
    end
  end

  def require_authority!
    unless has_authority?
      flash[:errors] = ["You can't access to this page!"]
      sign_out
      redirect_to new_session_url
    end
  end

  def require_doctor_authority!
    unless has_doctor_authority?
      flash[:errors] = ["Only doctors can access this page!"]
      sign_out
      redirect_to new_session_url
    end
  end

  def require_doctor_status!
    unless current_user.is_doctor
      flash[:errors] = ["Only doctors can access this page!"]
      sign_out
      redirect_to new_session_url
    end
  end

  def require_alert_authority!
    unless has_alert_authority?
      flash[:errors] = ["Only doctors can access this page!"]
      sign_out
      redirect_to new_session_url
    end
  end

  def has_doctor_authority?
    # (current_user.id == check_id && current_user.is_doctor)
    # fail
    ((current_user.id == params[:id].to_i) && current_user.is_doctor)
  end

  def has_alert_authority?
    ((current_user.id == Alert.find(params[:id]).doctor_id && current_user.is_doctor))
  end

  def has_authority?
    check_id = find_user_id

    ((current_user.id == check_id) || (current_user.is_patient_doctor?(check_id)))
  end


  # NOTE: Doesn't work unless routes are nested under user
  def find_user_id
    if (params[:user_id])
      return params[:user_id].to_i
    else
      return params[:id].to_i
    end
  end

  def create_from_google_data(google_data)
    # Check if user can be found by email / firstname / last_name?
    new_user = User.find_by_email(google_data[:info][:email])

    if new_user
      new_user.update_attributes({
        uid: google_data[:uid],
        provider: google_data[:provider],
        access_token: google_data[:credentials][:token]
      })
    else
      new_user = User.new(
              uid: google_data[:uid],
              provider: google_data[:provider],
              access_token: google_data[:credentials][:token],
              first_name: google_data[:info][:first_name],
              last_name: google_data[:info][:last_name],
              email: google_data[:info][:email],
              password: User.generate_session_token
            )

      new_user.health.build()

      if current_user && current_user.is_doctor
        new_user.doctor_id = current_user.id
      end
      
      new_user.save
      UserMailer.activation_email(new_user).deliver!
    end

    
    new_user
  end
  
  def set_timezone
    @user = @user || User.find(params[:user_id])
    Time.zone = @user.timezone
    Chronic.time_class = Time.zone
  end
  
  # Returns true if the params passwords match
  def password_confirmed?
    params[:password] != params[:user][:password]
  end

end
