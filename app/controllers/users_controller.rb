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

  def step3
    session[:age] = user_params[:age]
    session[:gender] = user_params[:gender]
    session[:business] = user_params[:business]
    session[:hobby] = user_params[:hobby]
    @user = User.new
    @wish_list = WishList.new
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(
        name: session[:name],
        email: session[:email],
        password: session[:password],
        password_confirmation: session[:password_confirmation],
        age: session[:age],
        gender: session[:gender],
        business: session[:business],
        hobby: split_hobby(session[:hobby])
      )

      wish_list_params.each do |wish_list_param|
        @user.wish_lists.build(wish_list_param)
      end

      @user.save!
    end

    session.clear
    session[:user_id] = @user.id
    redirect_to root_path, notice: t('registration.success')

  rescue ActiveRecord::RecordInvalid
    session.clear
    redirect_to step1_users_path, alert: @user.errors.full_messages
  end

  def edit; end

  def update; end

  def check_email
    email = params[:email]
    user_exists = User.exists?(email: email)
    render json: { exists: user_exists }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :business, :hobby)
  end

  def wish_list_params
    params.require(:user).permit(wish_lists_attributes: %i[item_name description])[:wish_lists_attributes].values
  end

  def split_hobby(hobby_str)
    return [] if hobby_str.nil?
    hobby_str.split(/[,、・]/).reject(&:empty?)
  end
end
