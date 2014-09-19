class DiagnosesController < ApplicationController
  require 'addressable/uri'

  before_filter :require_signed_in!
  before_filter :require_authority!


  def index
    @user = User.find(params[:user_id])
    @patient_diagnoses = @user.patient_diagnoses.includes(:diagnosis).page(params[:page]).per(10)
  end

  def add_diagnosis
    # TODO: could refactor to do one :pg_search instead of short circuiting
    @diagnosis = Diagnosis.find_by_code(params[:query]) || Diagnosis.find_by_description(params[:query])
    @user = User.find(params[:user_id])

    respond_to do |format|
      if @diagnosis
        @patient_diagnosis = @diagnosis.patient_diagnoses.create(patient: @user)
        if @patient_diagnosis.errors.full_messages.empty?
          flash.now[:notices] = ["Diagnosis Added."]
        else
          flash.now[:errors] = @patient_diagnosis.errors.full_messages
        end
      else
        url = Addressable::URI.new(
                              scheme: "http",
                              host: "www.icd10api.com",
                              query_values: {code: params[:query], r: "json", desc: "long"})
        resp = JSON.parse(RestClient.get(url.to_s))

        if resp["Response"] == "True"
          @diagnosis = Diagnosis.create({code: resp["Name"], description: resp["Description"]})
          @patient_diagnosis = @diagnosis.patient_diagnoses.create(patient: @user)
          flash.now[:notices] = ["Diagnosis Added."] unless flash[:errors]
          if (@patient_diagnosis.errors.full_messages.empty? || @diagnosis.errors.full_messages.empty?)
            flash.now[:notices] = ["Diagnosis Added."]
          else
            flash.now[:errors] = @patient_diagnosis.errors.full_messages + @diagnosis.errors.full_messages
          end
        else
          flash.now[:errors] = ["Code not found!"]
        end
      end
      
      format.html { redirect_to user_diagnoses_url(@user) }
      format.js
    end
  end

  def destroy
    @patient_diagnosis = PatientDiagnosis.find(params[:id])

    @patient_diagnosis.destroy
    respond_to do |format|
      format.html {
        flash[:notices] = ["#{@patient_diagnosis.diagnosis.description} diagnoses deleted."]
        fail
        redirect_to user_diagnoses_url(params[:user_id])
      }
      
      format.js {
        flash.now[:notices] = ["#{@patient_diagnosis.diagnosis.description} diagnoses deleted."] 
        render
      }
    end
  end

end
