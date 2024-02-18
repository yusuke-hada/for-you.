class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    login_from(provider)
    if @user = current_user
      provider_user_id = @user_hash.dig(:user_info, "userId")
      @user.update(line_uid: provider_user_id)
      redirect_to root_path, notice: t('.success')
    else
      if auth_params[:denied].present?
        redirect_to root_path, notice: t('.cancel')
        return
      end
      create_user_from(provider) unless login_from(provider)
      redirect_to root_path, notice: t('.success')
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def create_user_from(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
