class WishListsController < ApplicationController
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
end
