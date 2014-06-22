class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find( session[:user_id] ) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  protected
    def authorize_user
      unless logged_in?
        flash[:notice] = "You must log in first."
        redirect_to login_path
      end
    end

    def authorize_admin
      unless current_user.admin?
        access_denied
      end
    end

    def access_denied
      flash[:notice] = "You do not have rights to do this."
      redirect_to :back
    end
end
