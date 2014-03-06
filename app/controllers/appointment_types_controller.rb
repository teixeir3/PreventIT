class AppointmentTypesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_status!

  def index
    @doctor = current_user
    @appointment_types = current_user.appointment_types
    # fail
  end

  def new
    @doctor = current_user
    @appointment_type = current_user.appointment_types.new
  end

  def create
    @appointment_type = current_user.appointment_types.build(params[:appointment_type])
    @appointment_type.diagnosis_ids = params[:diagnoses_ids]

    if @appointment_type.save
      redirect_to appointment_types_url
    else
      flash.now[:errors] = @appointment_type.errors.full_messages
      render :new
    end
  end

end
