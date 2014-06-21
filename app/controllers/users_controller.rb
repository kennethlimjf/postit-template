class UsersController < ApplicationController
  before_action :authorize_user, except: [:new, :create]

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
    @posts = current_user.posts
    @comments = current_user.comments
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "Profile successfully updated."
      redirect_to profile_path
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :time_zone)
    end
end