class AppointmentTypesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_status!

  def index
    @doctor = current_user
    @appointment_types = current_user.appointment_types
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

  def edit
    @doctor = current_user
    @appointment_type = current_user.appointment_types.find(params[:id])
  end

  def update
    @appointment_type = current_user.appointment_types.find(params[:id])
    @appointment_type.diagnosis_ids = params[:diagnoses_ids]

    if @appointment_type.update_attributes(params[:appointment_type])
      flash.now[:notice] = "Appointment Type Updated."
    else
      flash.now[:errors] = @appointment_type.errors.full_messages
    end

    render :edit
  end
  
  def destroy
    @appointment_type = AppointmentType.find_by_id_and_doctor_id(params[:id], current_user.id)
    @doctor = current_user
    @appointment_type.destroy
  
    respond_to do |format|
      format.html { 
        flash[:notices] = ["#{@appointment_type.name} appointment deleted."]
        redirect_to appointment_types_url }
      format.js do
        flash.now[:notices] = ["#{@appointment_type.name} appointment deleted."]
        render "application/_flash_messages", :status => 200
      end
    end
  end
  
  def delete
    @doctor = current_user
    @deletable = AppointmentType.find_by_id_and_doctor_id(params[:id], current_user.id)
  end

end
