class MemosController < ApplicationController
  before_action :set_memo, only: [:edit,:update,:destroy]

  def index
    @q = Memo.ransack(params[:q])
    @memos = @q.result(distinct: true).includes(:user).where(user: current_user).page(params[:page]).order("created_at desc").per(10)
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      redirect_to user_memos_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @memo.errors.full_messages
      render :new
    end
  end

  def edit ;end

  def update
    if @memo.update(memo_params)
      redirect_to user_memos_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @memo.errors.full_messages
      render :edit
    end
  end

  def destroy
    @memo.destroy!
    redirect_to user_memos_path, alert: t('.success'), status: :see_other
  end


  private

  def memo_params
    params.require(:memo).permit(:name, :goods, :time)
  end

  def set_memo
    @memo = current_user.memos.find(params[:id])
  end
end