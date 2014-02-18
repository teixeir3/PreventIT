class RemindersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @reminders = @user.reminders
  end

  def new
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.build# Reminder.new
  end

  def create
    @user = User.find(params[:user_id])

    unless params[:days].nil?
      params[:days].each do |day|
        params[:times].each do |time|
          next if time == ""
          rem = @user.reminders.build(params[:reminder])
          rem.day = day
          rem.time = time
        end
      end
    end

    if @user.save && params[:days]
      redirect_to user_reminders_url(@user)
    else
      flash.now[:errors] = @user.reminders.map(&:errors).map(&:full_messages)
      render :new
    end
  end

  def complete
    @user = User.find(params[:user_id])
    @reminder = Reminder.find(params[:id])
    @reminder.complete = true

    redirect_to user_reminders_url(@user)
  end

  # def destroy
#
#   end
end
