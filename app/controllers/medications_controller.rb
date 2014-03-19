class MedicationsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  
  def index
    @user = User.find(params[:user_id])
    @patient_medications = @user.patient_medications.includes(:medication).page(params[:page]).per(10)
  end
  
  def  new
    @patient_medication = PatientMedication.new
  end
  
  def create
    
  end
  
end
