class AlertsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_authority!

  def index
    @doctor = current_user
    @alerts = @doctor.incomplete_alerts.page(params[:page]).per(20)
  end

  def completed
    @doctor = current_user
    @alerts = @doctor.complete_alerts.page(params[:page]).per(20)
  end

  def show
    @alert = Alert.find(params[:id])
    @patient = @alert.patient
  end

  def mark_complete
    @alert = Alert.find(params[:id])
    @alert.complete = true

    @alert.save

    redirect_to alerts_url
  end
end
