class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    login_from(provider) # これやると@user_hashが使えるようになる
    if @user = current_user
      # 既にログインしているユーザーがLINEアカウントと連携する処理
      binding.pry
      provider_user_id = @user_hash.dig(:user_info, "userId") # @user_hashにuserIdが入ってるからそれと紐付けを行う
      @user.update(line_uid: provider_user_id)
      redirect_to root_path, notice: 'LINEアカウントと連携しました'
    else
      # 新規ユーザー作成またはログイン処理
      if auth_params[:denied].present?
        redirect_to root_path, notice: "LINE連携をキャンセルしました"
        return
      end
      create_user_from(provider) unless login_from(provider)
      redirect_to root_path, notice: "LINEアカウントと連携しました"
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
