class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(root_path, notice: t('.success'))
    else
      flash.now[:alert] = t('.failed')
      render :new
    end
  end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています' if current_user

    random_value = SecureRandom.hex
    user = User.create!(name: random_value, email: "#{random_value}@example.com", password: random_value.to_s,
                        password_confirmation: random_value.to_s, age: 20, gender: 2)
    auto_login(user)
    redirect_to root_path, notice: 'ゲストとしてログインしました'
  end

  def destroy
    logout
    redirect_to login_path, notice: t('.success'), status: :see_other
  end
end
