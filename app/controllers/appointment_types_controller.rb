class AppointmentTypesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_status!

  def new
    @doctor = current_user
    @appointment_type = current_user.appointment_types.new
  end

  def index
    @doctor = current_user
    @appointment_types = current_user.appointment_types
  end
end
