class ApplicationController < ActionController::Base
  include ZT
#  protect_from_forgery with: :exception
  before_action :set_locale
end
