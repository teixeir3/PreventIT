class DiagnosesController < ApplicationController
  require 'addressable/uri'

  before_filter :require_signed_in!
  before_filter :require_authority!


  def index
    @user = User.find(params[:user_id])
    @patient_diagnoses = @user.patient_diagnoses.includes(:diagnosis).page(params[:page]).per(10)
    # @diagnoses = @user.diagnoses.includes(:patient_diagnoses)
  end

  def add_diagnosis
    @diagnosis = Diagnosis.find_by_code(params[:query]) || Diagnosis.find_by_description(params[:query])
    @user = User.find(params[:user_id])

    if @diagnosis
      @patient_diagnosis = @diagnosis.patient_diagnoses.create(patient: @user)
      flash[:errors] = @patient_diagnosis.errors.full_messages
      redirect_to user_diagnoses_url(@user)
    else
      url = Addressable::URI.new(
                            scheme: "http",
                            host: "www.icd10api.com",
                            query_values: {code: params[:query], r: "json", desc: "long"})
      resp = JSON.parse(RestClient.get(url.to_s))

      if resp["Response"] == "True"
        @diagnosis = Diagnosis.create({code: resp["Name"], description: resp["Description"]})
        @diagnosis.patient_diagnoses.create(patient: @user)
        flash[:errors] = @diagnosis.errors.full_messages
        redirect_to user_diagnoses_url(@user)
      else
        flash[:errors] = ["Code not found!"]
        redirect_to user_diagnoses_url(@user)
      end
    end
  end

  def destroy
    @patient_diagnosis = PatientDiagnosis.find(params[:id])

    @patient_diagnosis.destroy
    redirect_to user_diagnoses_url(params[:user_id])
  end

end
