################################################################################
# The Parent Controller for Admin
#
# 19.09.2016  ZT
# 09.11.2016  back-update
# 14.01.2017  Pundit procedure
#             Flash handlig
# 18.08.2017  replace 'before_filter' with 'before_action'
################################################################################
class Admin::BaseController < ApplicationController
  include Pundit
  include AdminAuthentication
  layout 'admin'

  protect_from_forgery with: :exception

  before_action :check_login
  before_action :current_user
  after_action  :verify_authorized, except: :index
#  after_action  :verify_policy_scoped, only: :index

  # Globally rescue Authorization Errors in a controller
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized  # permission denied

  add_flash_types :success, :info, :warning, :danger

  private

  def user_not_authorized
#   redirect_to(request.referrer || admin_root_path, alert: t('simple_form.alert.access_denied'))
    flash[:alert] = t('simple_form.alert.access_denied')
    redirect_to(request.referrer || admin_root_path)
  end
end
