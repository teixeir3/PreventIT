class DoctorsController < ApplicationController
  before_filter :require_signed_in!, :only => [:show, :edit]
  before_filter :require_doctor_authority!, :only => [:show, :edit]

  def new
    @practice = Practice.new
    @user = @practice.doctors.new
    render :new
  end

  def create
    @practice = Practice.new(params[:practice])
    @user = @practice.doctors.build(params[:user])
    @user.is_doctor = true
    @user.alert_setting.build

    if params[:password] != params[:user][:password]
      flash.now[:errors] = ["Your passwords did not match!"]
      render :new
    elsif @practice.save
      sign_in(@user)
      redirect_to doctor_url(@user)
    else
      flash.now[:errors] = @practice.errors.full_messages
      render :new
    end
  end

  def show
    @doctor = User.includes(:patients).find(params[:id])
    @patients = current_user.patients.page(params[:page]).per(10)
    render :show
  end
end
