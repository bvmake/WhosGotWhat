class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(omniauth)

    unless user && user.invitation
      logger.warn "Error looking up user from omniauth in SessionsController#create"
      redirect_to root_url, :alert => "There was an error finding your authentication information"
      return
    end

    case user.invitation.state
    when "accepted"
      sign_in(user)
      redirect_to dashboard_url

    when "pending"
      user.invitation.accept!
      sign_in(user)
      redirect_to dashboard_url

    when "waitlist"
      user.invitation.send_waitlist_email
      redirect_to on_waitlist_url

    else
      logger.warn "Invitation in unknown state #{citizen.invitation.state} in SessionsController#create"
      redirect_to root_url, :alert => "You have an invitation, but we don't know what to do with it. An administrator has been alerted"
    end
  end

private

  def omniauth
    fail "No omniauth" unless request.env["omniauth.auth"] || session[:omniauth]
    request.env["omniauth.auth"] || session[:omniauth]
  end

end
