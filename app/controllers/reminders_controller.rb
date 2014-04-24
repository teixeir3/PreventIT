class RemindersController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!

  def index
    @user = User.find(params[:user_id])

    @reminders = @user.incomplete_due_reminders.page(params[:page]).per(20)
  end

  def completed
    @user = User.find(params[:user_id])

    @reminders = @user.reminders.where(complete: true).page(params[:page]).per(20)
    render :index
  end
  
  def upcoming
    @user = User.find(params[:user_id])
    
    @reminders = @user.upcoming_reminders.page(params[:page]).per(20)
    render :index
  end

  def new
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.build
    @days = []
    @times = []
  end

  def create
    reminders = []
    @user = User.find(params[:user_id])
    num_reminders_created = 0
    @days = params[:days] || []
    @times = params[:times].select { |time| !time.blank? } || []
    
    @reminder = @user.reminders.build(params[:reminder])
    fail
    unless params[:days].nil?
      @times.each do |time|
        next if time.blank?
        @days.each do |day|
          num_reminders_created += 1
          
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

          if (day > new_date_time.wday)
            diff = day - new_date_time.wday
          else
            diff = 7 - day
          end

          @reminder.datetime = new_date_time.advance(days: diff)
          reminders << @reminder
          fail
          # 11.times do |x|
#             new_rem = @user.reminders.build(params[:reminder])
#             new_rem.datetime = @reminder.datetime.advance(weeks: x + 1)
#             reminders << new_rem
#           end
        end
        @reminder = @user.reminders.build(params[:reminder]) unless time == @times.last
      end
    end
    
    fail
    if num_reminders_created > 0 && @user.save
      redirect_to user_reminders_url(@user)
    else
      flash.now[:errors] = @user.reminders.map(&:errors).map(&:full_messages).select { |el| !el.empty? }
      # flash.now[:errors] << "At least 1 days / time must be picked!" if num_reminders_created == 0
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
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

  # def show
#     @user = User.find(params[:user_id])
#     @reminder = Reminder.find(params[:id])
#   end


  # def destroy
#
#   end
end
