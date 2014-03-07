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
      redirect_to user_appointments_url(@user)
    else
      flash.now[:errors] = @user.appointments.last.errors.full_messages
      render :new
    end

  end

  def destroy

  end

  def edit

  end

  def update

  end
end
