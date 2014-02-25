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

  end
end
