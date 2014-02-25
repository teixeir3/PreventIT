class PagesController < ApplicationController
  before_filter :require_signed_in!
  # before_filter :require_doctor_authority!

  def new
  end

  def search_patients

    @results = User.search_on_name(params[:query]).page(params[:page]).per(10)
    # if params[:query]
#       @results = PgSearch.search_on_name(params[:query])
#     else
#       @results = PgSearch::Document
#     end
#
#     @results = @results.includes(:searchable).page(params[:page])
  end

  def search_diagnoses
    @diagnosis = Diagnosis.find_by_code(params[:query])
    # @diagnosis_results = Diagnosis.

    if @diagnosis

    else
      url = Addressable::URI.new(
                            scheme: "http",
                            host: "www.icd10api.com",
                            query_values: {
                              code: params[:query],
                              r: "json",
                              desc: "long"
                              }
                            )
      resp = RestClient.get(url.to_s)

      if resp["Response"] == "true"
        new_diagnosis = Diagnosis.create({
                                  code: resp["Name"],
                                  description: resp["Description"]
                                  })
      else

      end
    end
  end
end

# {"Name":"A001","Description":"Cholera due to Vibrio cholerae 01, biovar eltor","Valid":"1","Inclusions":["Cholera eltor"],"ExcludesOne":[],"ExcludesTwo":[],"Type":"ICD-10-CM","Response":"True"}
