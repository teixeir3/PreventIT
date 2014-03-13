class AppointmentsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!

  def index
    @user = User.find(params[:user_id])
    @appointments = @user.appointments.page(params[:page]).per(20)
  end

  def new
    @user = User.includes(diagnoses: [:appt_types]).find(params[:user_id])
    # @appt_types = @user.diagnoses.appt_types
    @appointment = @user.appointments.build
  end

  def create
    @user = User.find(params[:user_id])
    params[:appointment][:datetime] = params[:date] + " " + params[:time]

    @appointment = @user.appointments.build(params[:appointment])

    @appointment.doctor_id = params[:doctor_id] if @user.doctor_id = params[:doctor_id]

    if @user.save
          @reminder = Reminder.create_appt_reminder(@appointment)# @user.reminders.create({
#         datetime: @appointment.datetime,
#         title: "#{@appointment.appointment_type.name} appointment with Dr. #{@appointment.doctor.full_name}",
#         rem_type: "appointment",
#         patient_id: @appointment.patient_id,
#         sub_type: @appointment.appointment_type.name
#       })

      redirect_to user_appointments_url(@user)
    else
      flash.now[:errors] = @user.appointments.last.errors.full_messages
      render :new
    end

  end

  # THESE THREE ARE UNTESTED VVV
  def destroy
    @appointment = Appointment.find(params[:id])

    # TODO: This leaves a reminder tied to the appointment still free floating. May need polymorphic relationship
    @appointment.destroy
    redirect_to user_appointments_url(@appointment.patient_id)
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @user = @appointment.patient
  end

  def update
    @appointment = Appointment.find(params[:id])
    @user = @appointment.patient
    
    params[:appointment][:datetime] = params[:date] + " " + params[:time]
    
    if @appointment.update_attributes(params[:appointment])
      render :edit
    else
      flash.now[:errors] = @appointment.errors.full_messages
      render :edit
    end
  end
end
