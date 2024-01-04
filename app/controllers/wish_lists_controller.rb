class WishListsController < ApplicationController
  def index
    @q = WishList.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).page(params[:page]).order("created_at desc")
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
