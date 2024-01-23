class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    permitted_params = params.require(:user).permit(:email, :name, :age, :gender, :business, :hobby)
    permitted_params[:hobby] = split_hobby(permitted_params[:hobby]) if permitted_params[:hobby].is_a?(String)
    permitted_params
  end

  def split_hobby(hobby_str)
    return [] if hobby_str.nil?

    hobby_str.split(/[,、・]/).reject(&:empty?)
  end
end
