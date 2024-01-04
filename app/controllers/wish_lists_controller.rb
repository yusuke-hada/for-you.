class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:edit,:update,:destroy]

  def index
    @q = WishList.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).page(params[:page]).order("created_at desc")
  end

  def new
    @wish_list = WishList.new
  end

  def create
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      redirect_to user_wish_lists_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @wish_list.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to user_wish_lists_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @wish_list.errors.full_messages
      render :edit
    end
  end

  def destroy
    @wish_list.destroy!
    redirect_to user_wish_lists_path, alert: t('.success'), status: :see_other
  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:item_name, :description)
  end

  def set_wish_list
    @wish_list = current_user.wish_lists.find(params[:id])
  end
end
