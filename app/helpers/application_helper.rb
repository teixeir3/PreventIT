module ApplicationHelper

  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\"
    value=\"#{form_authenticity_token}\">".html_safe
  end

  def is_doctor?(user)
    current_user.id == user.doctor_id
  end
end
