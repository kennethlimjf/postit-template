class UsersController < ApplicationController
  before_action :authorize_user, except: [:new, :create, :show]

  def new
  end

  def create
    @user  = User.new( user_params )

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "New user has been created. You are logged in now."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if current_user.update_attributes(update_user_params)
      flash[:notice] = "Profile successfully updated."
      redirect_to profile_path(current_user)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :time_zone)
    end

    def update_user_params
      params.require(:user).permit(:password, :password_confirmation, :time_zone)
    end
end