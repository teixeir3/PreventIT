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
    @user.health.build()

    if current_user && current_user.is_doctor
      @user.doctor_id = current_user.id
    end

    if password_confirmed?
      flash.now[:errors] = ["Your passwords did not match!"]
      render :new
    elsif @user.save
      
      # Sends activation email
      UserMailer.activation_email(@user).deliver!
      sign_in(@user) unless current_user and current_user.is_doctor
      
      if current_user.is_doctor
        redirect_to doctor_url(current_user.id)
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

    if @user.update_attributes(params[:user]) && @user.health[0].update_attributes(params[:health])
      flash[:notices] = ["User Updated."]
      if has_doctor_authority?
        redirect_to doctor_url(@user)
      else
        redirect_to user_url(@user)
      end
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    
    if params[:activation_token] && @user
      @user.activate!
      sign_in(@user)
      flash[:errors] =  ["Successfully activated your account!"]
      redirect_to @user
    else
      raise ActiveRecord::RecordNotFound.new()
    end
  end
  
 ## Moved to PasswordResetsController
 #  def password_reset
 #    
 #  end
 #  
 ## Moved to PasswordResetsController
 #  def password_update
 #    @user = User.find_by_activation_token(params[:activation_token])
 #    
 #    if password_confirmed?
 #      @user.password = params[:user][:password]
 #      
 #      if @user.save
 #        flash.now[:errors] = ["Password changed successfully!"]
 #        render :show
 #      else
 #        flash.now[:errors] = @user.errors.full_messages
 #        render
 #        redirect_to
 #      end
 #    else
 #      redirect_to
 #    end
 #  end
end