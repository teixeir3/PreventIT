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
    url = Addressable::URI.new(
                          scheme: "http",
                          host: "rxnav.nlm.nih.gov",
                          path: "/REST/spellingsuggestions",
                          query_values: {name: params[:query]})
    @results = JSON.parse(RestClient.get(url.to_s, content_type: :json, accept: :json))

    @results = (@results["suggestionGroup"]["suggestionList"]) ? @results["suggestionGroup"]["suggestionList"]["suggestion"] : []
    render json: @results
  end
  
  # def search_medications
#     @results = Medication.search_on_name(params[:query])
#     @results = @results.map(&:name) unless @results.empty?
#     # if @results.empty?
#       url = Addressable::URI.new(
#                             scheme: "http",
#                             host: "rxnav.nlm.nih.gov",
#                             path: "/REST/spellingsuggestions",
#                             query_values: {name: params[:query]})
#       @new_results = JSON.parse(RestClient.get(url.to_s, content_type: :json, accept: :json))
#       
#       @new_results = @results["suggestionGroup"]["suggestionList"]["suggestion"]
#     # else
#       
#     # end
#     
#     render json: @results
#   end
end
