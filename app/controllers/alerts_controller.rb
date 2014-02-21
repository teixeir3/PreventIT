class AlertsController < ApplicationController

  def index
    @doctor = User.find(params[:doctor_id])
    @alerts = @doctor.alerts
  end
end
