module ZT
  ##############################################################################
  #   18.11.2016  ZT
  #   09.01.2017  Updated (folowing the RoR guide) *set_locale*
  #               *default_url_options* added
  ##############################################################################

  ##############################################################################
  # Adds multiple url options (*locale* here).
  #
  # An alternative solution: *polymorphic* urls (e.g. redirect_to polymorphic_url)
  ##############################################################################
  def default_url_options
    { locale: I18n.locale }
  end

  ##############################################################################
  #   Sets locale  before_action
  #   Called by:   application_controller.rb & sessions_controller.rb
  ##############################################################################
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
