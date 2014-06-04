class SymptomsController < ApplicationController
  before_filter :require_signed_in!
  before_filter :require_authority!
  
  def index
    @user = User.includes(:symptoms).find(params[:user_id])
    @symptoms = @user.symptoms.page(params[:page]).per(10)
  end
  
  def new
    @user = User.find(params[:user_id])
    @symptom = @user.symptoms.new
  end
  
  def show
    
  end
  
  def create
    
  end
  
  def edit
    
  end

  def update
    
  end
  
  def destroy
    
  end
end
