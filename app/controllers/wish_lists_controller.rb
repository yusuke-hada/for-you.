class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:edit,:update,:destroy]

  def index
    @q = WishList.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).page(params[:page]).order("created_at desc")
  end

  def edit; end

  def update; end

  def destroy
    @wish_list.destroy!
    redirect_to user_wish_lists_path, alert: t('.success'), status: :see_other
  end

  private

  def set_wish_list
    @wish_list = current_user.wish_lists.find(params[:id])
  end
end
