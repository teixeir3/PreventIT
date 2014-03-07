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
end
