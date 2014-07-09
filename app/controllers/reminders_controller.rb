class RemindersController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  before_filter :set_timezone, only: :create

  def index
    @user = User.find(params[:user_id])

    @reminders = @user.incomplete_due_reminders.order(:datetime).page(params[:page]).per(20)
  end

  def completed
    @user = User.find(params[:user_id])

    @reminders = @user.reminders.where(complete: true).order(:datetime).page(params[:page]).per(20)
    render :index
  end
  
  def upcoming
    @user = User.find(params[:user_id])
    
    @reminders = @user.upcoming_reminders.order(:datetime).page(params[:page]).per(20)
    render :index
  end

  def new
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.build
    @days = []
    @times = []
  end

  # Creates (x = 12 weeks worth of reminders for each day / time combination.
  # Corresponds with reminder self propagation.
  def create
    reminders = []
    @days = params[:days] || []
    @times = params[:times].reject { |time| time.blank? }
    today_str = Time.zone.now.strftime("%A")
    
    @days.each do |day|
      @times.each do |time|
        new_time = (today_str == day) ? Chronic.parse("today at #{time}") : Chronic.parse("next #{day} at #{time}")
        new_time = new_time.advance(weeks: 1) if (new_time.past?) 
        reminders << @reminder = @user.reminders.build(params[:reminder])
        @reminder.datetime = new_time
        
        11.times do |x|
          new_rem = @user.reminders.build(params[:reminder])
          new_rem.datetime = @reminder.datetime.advance(weeks: x + 1)
          reminders << new_rem
        end
      end
    end
    
    if @user.save
      flash.now[:notices] = ["Reminder created!"]
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
      flash.now[:notices] = ["Reminder created!"]
      redirect_to user_reminders_url(params[:user_id])
    else
      flash.now[:errors] = @reminder.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def find_remindable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def create_remindable
    @remindable = find_remindable
    @reminder = @remindable.reminders.create(params[:reminder])
  end
  
  # def show
#     @user = User.find(params[:user_id])
#     @reminder = Reminder.find(params[:id])
#   end


  # def destroy
#
#   end
end
