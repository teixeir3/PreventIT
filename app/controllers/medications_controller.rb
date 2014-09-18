class MedicationsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  
  def index
    @user = User.includes(patient_medications: :medication).find(params[:user_id])
    @patient_medications = @user.patient_medications.page(params[:page]).per(20)
    
    respond_to do |format|
      format.html
      format.json { 
        render json: @patient_medications
      }
    end
  end
  
  def  new
    @user = User.includes(:patient_diagnoses => :diagnosis).find(params[:user_id])
    @patient_medication = @user.patient_medications.new
    @patient_diagnoses = @user.patient_diagnoses
  end
  
  def create
    @user = User.includes(:patient_diagnoses => :diagnosis).find(params[:user_id])
    @patient_diagnoses = @user.patient_diagnoses
    
    @medication = Medication.find_by_name(params[:medication][:name]) || Medication.new(name: params[:medication][:name])
    @patient_medication = @medication.patient_medications.build(params[:patient_medication])
    @patient_medication.patient = @user
    
    if @medication.save
      redirect_to user_medications_url(@user)
    else
      flash.now[:errors] = @medication.errors.full_messages
      render :new
    end
  end
  
  def edit
    @user = User.includes(:patient_medications, :patient_diagnoses => :diagnosis).find(params[:user_id])
    @patient_medication = @user.patient_medications.find(params[:id])
    @patient_diagnoses = @user.patient_diagnoses
  end
  
  def update
    @user = User.includes(:patient_medications, :patient_diagnoses => :diagnosis).find(params[:user_id])
    @patient_medication = @user.patient_medications.find(params[:id])
    @patient_diagnoses = @user.patient_diagnoses
    @patient_medication.medication = Medication.find_by_name(params[:medication][:name]) || Medication.new(name: params[:medication][:name])
    
    if @patient_medication.update_attributes(params[:patient_medication])
      render :edit
    else
      flash.now[:errors] = @patient_medication.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @user = User.includes(:patient_medications).find(params[:user_id])
    @patient_medication = @user.patient_medications.find(params[:id])
    
    @patient_medication.destroy
    redirect_to user_medications_url(@user)
  end
  
end
