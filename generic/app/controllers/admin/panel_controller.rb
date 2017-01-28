class Admin::PanelController < Admin::BaseController
  def index
    @current_user = current_user
  end
end
