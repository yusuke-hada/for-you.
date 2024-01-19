class PagesController < ApplicationController
  skip_before_action :require_login
  def top; end

  def after_login_top; end

  def privacy_policy; end

  def terms_of_use; end
end
