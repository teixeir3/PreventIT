class MedicationsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  
  def index
    @user = User.find(params[:user_id])
    @patient_medications = @user.patient_medications.includes(:medication).page(params[:page]).per(10)
  end
  
  def  new
    @user = User.find(params[:user_id])
    @patient_medication = @user.patient_medications.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @medication = Medication.find(medication[:name])
    
    unless @medication
      url = Addressable::URI.new(
                            scheme: "http",
                            host: "rxnav.nlm.nih.gov",
                            path: "/REST/spellingsuggestions",
                            query_values: {name: params[:query]})
      @results = JSON.parse(RestClient.get(url.to_s, content_type: :json, accept: :json))
      @results = @results["rxnormdata"]["idGroup"]
    end
  end
  
end
