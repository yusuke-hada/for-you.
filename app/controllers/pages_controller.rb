class PagesController < ApplicationController
  skip_before_action :require_login
  def top; end

  def after_login_top; end
end
