class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(new_user_path, notice: t('.success'))
    else
      flash.now[:alert] = t('.failed')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: t('.success'), status: :see_other
  end
end
