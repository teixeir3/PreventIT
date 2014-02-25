class DiagnosesController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!


  def index
    @diagnoses = current_user.diagnoses
    fail
  end

end
