class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_signed_in?

protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    @current_user = session[:user_id] = nil
  end


  def sign_in(user)
    session[:user_id] = user.id
  end


  def user_signed_in?
    !! current_user
  end

end
