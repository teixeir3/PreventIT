class PagesController < ApplicationController
  before_filter :require_signed_in!
  # before_filter :require_doctor_authority!

  def new
  end

  def search_patients

    @results = User.search_on_name(params[:query]).where(doctor_id: current_user.id).page(params[:page]).per(10)
    # if params[:query]
#       @results = PgSearch.search_on_name(params[:query])
#     else
#       @results = PgSearch::Document
#     end
#
#     @results = @results.includes(:searchable).page(params[:page])
  end

  def search_diagnoses
    @results = Diagnosis.search_on_code_and_description(params[:query])

    render json: @results

    # if request.xhr?
#       render json: @results
#     end
  end
end

# {"Name":"A001","Description":"Cholera due to Vibrio cholerae 01, biovar eltor","Valid":"1","Inclusions":["Cholera eltor"],"ExcludesOne":[],"ExcludesTwo":[],"Type":"ICD-10-CM","Response":"True"}
