class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by( username: params[:username] ).try( :authenticate, params[:password] )

    if user
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in."
      redirect_to root_path
    else
      flash[:error] = "There's a problem with your username and password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have succesfully logged out."
    redirect_to root_path
  end
end