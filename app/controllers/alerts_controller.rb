class AlertsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_doctor_authority!

  def index
    @doctor = User.find(params[:doctor_id])
    @complete_alerts = @doctor.complete_alerts
    @incomplete_alerts = @doctor.incomplete_alerts
  end

  def show
    @alert = Alert.find(params[:id])
    @patient = @alert.patient
  end

  def mark_complete
    @alert = Alert.find(params[:id])
    @alert.complete = true

    @alert.save

    redirect_to doctor_alerts_url(@alert.patient.doctor_id, @alert)
  end
end
