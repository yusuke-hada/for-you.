class WishListsController < ApplicationController
  before_action :set_wish_list, only: %i[edit update destroy]

  def index
    @q = WishList.ransack(params[:q])
    @wish_lists = @q.result(distinct: true)
                    .includes(:user)
                    .page(params[:page])
                    .order('wish_lists.created_at desc')
                    .per(10)
    apply_hobby_filter if params[:hobby].present?
  end

  def new
    @wish_list = WishList.new
  end

  def create
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      redirect_to wish_lists_path, notice: t('.success')
    else
      flash.now[:alert] = @wish_list.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @wish_list.update(wish_list_params)
      redirect_to wish_lists_path, notice: t('.success')
    else
      flash.now[:alert] = @wish_list.errors.full_messages
      render :edit
    end
  end

  def destroy
    @wish_list.destroy!
    redirect_to wish_lists_path, alert: t('.success'), status: :see_other
  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:item_name, :description)
  end

  def set_wish_list
    @wish_list = current_user.wish_lists.find(params[:id])
  end

  def apply_hobby_filter
    @wish_lists = @wish_lists.joins(:user).merge(User.with_hobby(params[:hobby]))
  end
end
