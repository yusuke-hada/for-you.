class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning, :alert
  before_action :require_login

  private

  def not_authenticated
    flash[:alert] = t('messages.require_login')
    redirect_to login_path
  end
end
