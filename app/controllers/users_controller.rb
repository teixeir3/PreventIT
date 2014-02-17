class UsersController < ApplicationController
  # before_filter :require_doctor_status, :only => [:]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if current_user.is_doctor
      @user.doctor_id = current_user.id
    end

    if @user.save
      @user.sign_in! unless current_user.is_doctor
      if current_user.is_doctor
        render :doctor_show
      else
        render :show
      end
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update

  end

  def show
    @user = User.find(params[:id])
    if @user.is_doctor
      render :doctor_show
    else
      render :show
    end
  end

end
