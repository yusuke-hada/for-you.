class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, notice: t('.success')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      redirect_to login_path, notice: t('.success')
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
