class UsersController < ApplicationController
  # before_filter :require_doctor_status, :only => [:]
  # before_filter :require_signed_out!, :only => [:new, :create]
  before_filter :require_signed_in!, :only => [:show, :edit]
  before_filter :require_authority!, :only => [:show, :edit]

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
      sign_in(@user) unless current_user.is_doctor
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

end
