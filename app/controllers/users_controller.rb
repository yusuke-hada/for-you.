class UsersController < ApplicationController
  skip_before_action :require_login
  def step1
    @user = User.new
  end

  def step2
    set_user_session_step2
    @user = User.new
  end

  def step3
    set_user_session_step3
    @user = User.new
    @wish_list = WishList.new
  end

  # HACK: Refactor this method to reduce ABC size and method length.
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
    redirect_to root_path, notice: t('.success')
  rescue ActiveRecord::RecordInvalid
    session.clear
    redirect_to step1_users_path, alert: @user.errors.full_messages
  end

  def check_email
    email = params[:email]
    user_exists = User.exists?(email:)
    render json: { exists: user_exists }
  end

  private

  def set_user_session_step2
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
  end

  def set_user_session_step3
    session[:age] = user_params[:age]
    session[:gender] = user_params[:gender]
    session[:business] = user_params[:business]
    session[:hobby] = user_params[:hobby]
  end

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

  def line_connect
    @user_token = current_user.generate_token
    line_account_id = "@660masva" 
    @line_connect_url = "https://line.me/R/nv/recommendOA/#{line_account_id}?token=#{@user_token}"
  end
end
