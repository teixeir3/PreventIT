class RemindersController < ApplicationController

  def index
    @user = user.find(params[:user_id])
    @reminders = @user.reminders
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    @reminder.patient_id = current_user.id

    if @reminder.save
      redirect_to user_reminders(current_user)
    else
      flash.now[:errors] = @reminder.errors.full_messages
    end
  end

  def complete
    @reminder = Reminder.find(params[:id])
  end

  # def destroy
#
#   end
end
