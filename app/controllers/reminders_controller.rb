class RemindersController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  before_filter :set_timezone, only: [:create, :update]

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
    @remindable = find_remindable
    @reminder = @user.reminders.build(remindable: @remindable)
    @days = []
    @times = []
    
    
    respond_to do |format|
      format.html { render :new }
      format.js
      
      # if @remindable
 #        render :form
 #      else
 #
 #      end
    end
  end

  # Creates (x = 12 weeks worth of reminders for each day / time combination.
  # Corresponds with reminder self propagation.
  # TODO Refactor into helper methods.
  def create
    reminders = []
    @remindable = params[:remindable][:remindable_type] != "Other" && params[:remindable][:remindable_type].classify.constantize.where(patient_id: @user.id).find(params[:remindable][:remindable_id])
    @days = params[:days] || []
    @times = params[:times].reject { |time| time.blank? }
    today_str = Time.zone.now.strftime("%A")
    
    # should be helper method
    @days.each do |day|
      @times.each do |time|
        new_time = (today_str == day) ? Chronic.parse("today at #{time}") : Chronic.parse("next #{day} at #{time}")
        new_time = new_time.advance(weeks: 1) if (new_time.past?) 
        
        @reminder = @user.reminders.build(params[:reminder]) 
        if @remindable
          @reminder.remindable = @remindable
        else
          @reminder.remindable_type =  params[:remindable][:remindable_type]
        end
        @reminder.datetime = new_time
        reminders << @reminder
        
        
        11.times do |x|
          new_rem = @user.reminders.build(params[:reminder])
          
          # Advancing the datetime returns a new datetime and doesn't mutate original
          new_rem.datetime = @reminder.datetime.advance(weeks: x + 1)
          new_rem.remindable = @remindable
          new_rem.parent = reminders.last
          
          reminders << new_rem
        end
      end
    end
    
    respond_to do |format|
      if @user.save 
        flash[:notices] = ["Reminder created!"]
        format.html {
          if (@remindable)
            redirect_to polymorphic_url([@user, @remindable, :reminders])
          else
            redirect_to user_reminders_url(@user)
          end
        }
        format.js
      else
        flash.now[:errors] = @user.reminders.map(&:errors).map(&:full_messages).select { |el| !el.empty? }
        # flash.now[:errors] << "At least 1 days / time must be picked!" if num_reminders_created == 0
        fail
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])

    if @reminder.update_attributes(params[:reminder])
      flash.now[:notices] = ["Reminder updated!"]
      redirect_to user_reminders_url(params[:user_id])
    else
      flash.now[:errors] = @reminder.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def find_remindable(hash = params)
    hash.each do |name, value|
      if name =~ /(.+)_id$/
        next if $1 == "user"
        return $1.classify.constantize.where(patient_id: params[:user_id]).find(value)
      end
    end
    nil
  end
  
  # def create_remindable
 #    @remindable = find_remindable
 #    @reminder = @remindable.reminders.create(params[:reminder])
 #  end
  
  # def show
#     @user = User.find(params[:user_id])
#     @reminder = Reminder.find(params[:id])
#   end


  # def destroy
#
#   end
end
