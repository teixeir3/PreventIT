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

    @appointment = @user.appointments.build(params[:appointment])

    if @user.save
      redirect_to user_appointments_url(@user)
    else
      flash.now[:errors] = @user.reminders.first.errors.full_messages
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
