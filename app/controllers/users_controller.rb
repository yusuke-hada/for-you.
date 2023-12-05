class UsersController < ApplicationController
  def step1
    @user = User.new
  end

  def step2
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    @user = User.new
  end

  def create
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      age: user_params[:age],
      gender: user_params[:gender],
      business: user_params[:business],
      hobby: split_hobby(user_params[:hobby])
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_path
    else
      render '/users/step1'
    end
  end

  def edit; end

  def update; end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :business, :hobby)
  end

  def split_hobby(hobby_str)
    hobby_str.split(/[,、・]/).reject(&:empty?)
  end
end