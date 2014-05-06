module ApplicationHelper

  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\"
    value=\"#{form_authenticity_token}\">".html_safe
  end

  def is_doctor?(user)
    current_user.id == user.doctor_id
  end
  
  def link_to_destroy(name, url, fallback_url)
    link_to_function name, "confirm_destroy(this, '#{url}')", :href => fallback_url
  end
  
end
