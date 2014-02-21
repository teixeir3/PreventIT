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
    redirect_to user_url(current_user) if signed_in?
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

  def has_doctor_authority?
    check_id = find_user_id

    (current_user.id == check_id && current_user.is_doctor)
  end

  def has_authority?
    check_id = find_user_id

    ((current_user.id == check_id) || (current_user.is_patient_doctor?(check_id)))
  end

  def find_user_id
    if (params[:user_id])
      return params[:user_id].to_i
    elsif (params[:doctor_id])
      return params[:doctor_id].to_i
    else
      return params[:id].to_i
    end
  end
end
