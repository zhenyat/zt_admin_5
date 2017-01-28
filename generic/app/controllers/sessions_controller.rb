class SessionsController < ApplicationController
  include AdminAuthentication

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user
      if user.active?
        if user.authenticate(params[:session][:password])
          log_in user
          redirect_to admin_root_path
        else
          # Creates an alert message and re-render the login form
          redirect_to sessions_new_path, alert: t('simple_form.alert.incorrect_password')
        end
      else
        redirect_to sessions_new_path, alert: t('simple_form.alert.access_denied')
      end
    else
      # no user logged in
      # NB! render 'new' - not working with alert / notice
      flash[:alert] = t('simple_form.alert.incorrect_email')
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to sessions_new_path
  end

  def new
  end
end
