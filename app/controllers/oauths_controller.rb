class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    Rails.logger.info request.env['omniauth.auth'].inspect
    provider = auth_params[:provider]
    if @user = current_user
      # 既にログインしているユーザーがLINEアカウントと連携する処理
      provider_user_id = request.env['omniauth.auth']['userId'] # LINEから返されたユーザーID
      @user.update(line_uid: provider_user_id) # ユーザー情報にLINEユーザーIDを紐づける
      redirect_to root_path, notice: 'LINEアカウントと連携しました'
    else
      # 新規ユーザー作成またはログイン処理
      if auth_params[:denied].present?
        redirect_to root_path, notice: "#{provider.titleize}でのログインをキャンセルしました"
        return
      end
      create_user_from(provider) unless login_from(provider)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
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
