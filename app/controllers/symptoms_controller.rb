class SymptomsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  
  def index
    @user = User.includes(:symptoms).find(params[:user_id])
    @symptoms = @user.symptoms.page(params[:page]).per(10)
  end
  
  def new
    @user = User.find(params[:user_id])
    @symptom = @user.symptoms.new
  end
  
  # Uses edit as show page. TODO: Make fancy form that acts as both edit / show
  # def show
#
#   end
  
  def create
    @user = User.find(params[:user_id])
    params[:symptom][:datetime] = params[:date] + " " + params[:time]
    
    @symptom = @user.symptoms.build(params[:symptom])
    
    if @user.save
      flash.now[:notices] = ["Symptom Created!"]
      
      #TODO render show or edit? need to make template
      render :edit
    else
      flash.now[:errors] = @symptom.errors.full_messages
      render :new
    end
    
  end
    # 
  # def create
  #   @user = User.find(params[:user_id])
  #   params[:appointment][:datetime] = params[:date] + " " + params[:time]
  # 
  #   @appointment = @user.appointments.build(params[:appointment])
  # 
  #   @appointment.doctor_id = params[:doctor_id] if @user.doctor_id = params[:doctor_id]
  # 
  #   if @user.save
  #         @reminder = Reminder.create_appt_reminder(@appointment)
  # 
  #     redirect_to user_appointments_url(@user)
  #   else
  #     flash.now[:errors] = @user.appointments.last.errors.full_messages
  #     render :new
  #   end
  # 
  # end
  
  def edit
    @user = User.find(params[:user_id])
    @symptom = @user.symptoms.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @symptom = @user.symptoms.find(params[:id])
    
    if @symptom.update_attributes(params[:symptom])
      flash.now[:notices] = ["Symptom successfully updated!"]
      render :edit
    else
      flash.now[:errors] = @symptom.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @symptom = @user.symptoms.find(params[:id])
    
    @symptom.delete
    flash[:notices] = ["Symptom deleted successfully."]
    
    redirect_to user_symptoms_url(@user)
  end
end
