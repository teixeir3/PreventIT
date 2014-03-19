class PagesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_status!, only: [:search_patients]

  def new
  end

  def search_patients
    if params[:query].blank?
      @results = User.where(doctor_id: current_user.id).order(:last_name).page(params[:page]).per(15)
    else
      @results = User.search_on_name(params[:query]).where(doctor_id: current_user.id).order(:last_name).page(params[:page]).per(15)
    end
  end

  def search_diagnoses
    @results = Diagnosis.search_on_code_and_description(params[:query])

    render json: @results
  end
  
  def search_medications
    @results = Medication.search_on_name(params[:query])
    
    if @results.empty?
      url = Addressable::URI.new(
                            scheme: "http",
                            host: "rxnav.nlm.nih.gov",
                            path: "/REST/spellingsuggestions",
                            query_values: {name: params[:query]})
      @results = JSON.parse(RestClient.get(url.to_s, content_type: :json, accept: :json))
    end
    
    render json: @results
  end
end
