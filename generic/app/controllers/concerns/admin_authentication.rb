################################################################################
# Manages Admin user authentication
#
# 10.10.2014  ZT
# 25.08.2016  Methods from SessionsHelper were moved here
################################################################################
module AdminAuthentication
  extend ActiveSupport::Concern

  private

  # Checks whether user logged in or redirects to login page
  def check_login
    redirect_to sessions_new_path if session[:user_id].nil? #|| session[:role_id].nil?
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Logs in the given user.
  def log_in user
    session[:user_id]  = user.id
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def set_locale
    if MULTILINGUAL
      if params[:locale] == 'ru'
        I18n.locale = :ru
      else
        I18n.locale = :en
      end
    else
      I18n.locale = :ru
    end
  end
end