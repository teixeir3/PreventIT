class RemindersController < ApplicationController
  before_filter :require_signed_in!
  # before_filter :require_authority

  def index
    @user = User.find(params[:user_id])

    @reminders = @user.reminders.all

    @complete_reminders = @user.reminders.where(complete: true)
    @incomplete_reminders = @user.reminders.where(complete: false)

    @due_reminders = @user.due_reminders
  end

  def new
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.build
  end

  def create
    @user = User.find(params[:user_id])

    unless params[:days].nil?
      params[:times].each do |time|
        next if time.blank?

        params[:days].each do |day|
          rem = @user.reminders.build(params[:reminder])
          day = day.to_i
          new_date_time = Time.now
          hour = time.split(":")[0].to_i

          if (hour - 5 < 0)
            hour += (24 - 5)
          else
            hour -= 5
          end

          min = time.split(":")[1]
          new_date_time = new_date_time.change(hour: hour, min: min)

          if (day.to_i > new_date_time.wday)
            diff = day - new_date_time.wday
          else
            diff = 7 - day
          end

          rem.datetime = new_date_time.advance(days: diff)

          11.times do |x|
            new_rem = @user.reminders.build(params[:reminder])
            new_rem.datetime = rem.datetime.advance(weeks: x + 1)
          end
        end
      end
    end

    if @user.save && params[:days]
      redirect_to user_reminders_url(@user)
    else
      flash.now[:errors] = @user.reminders.first.errors.full_messages
      render :new
    end
  end

  def edit
    # @user = User.find(params[:user_id])
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])

    if @reminder.update_attributes(params[:reminder])
      redirect_to user_reminders_url(params[:user_id])
    else
      flash.now[:errors] = @reminder.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:user_id])
    @reminder = Reminder.find(params[:id])


  end


  # def destroy
#
#   end
end
