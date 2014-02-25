class DiagnosesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!


  def index
    @user = User.find(params[:user_id])
    @diagnoses = @user.diagnoses
  end

end
