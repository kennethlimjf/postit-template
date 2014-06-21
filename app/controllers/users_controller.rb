class UsersController < ApplicationController
  def new
  end

  def create
    @user  = User.new( username: params[:username], password: params[:password], password_confirmation: params[:password_confirm] )

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "New user has been created. You are logged in now."
      redirect_to root_path
    else
      render :new
    end
  end
end