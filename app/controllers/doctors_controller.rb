class DoctorsController < ApplicationController
  before_filter :require_signed_in!, :only => [:show, :edit]

  def new_doctor
    @practice = Practice.new
    @user = @practice.doctors.new
    render :new
  end

  def create
    @practice = Practice.new(params[:practice])
    @user = @practice.doctors.build(params[:user])
    @user.is_doctor = true

    if @practice.save
      sign_in(@user)
      redirect_to doctor_url(@user)
    else
      flash.now[:errors] = @practice.errors.full_messages
      render :doctor_new
    end
  end

  def show
    @doctor = User.find(params[:id])
    render :show
  end
end
