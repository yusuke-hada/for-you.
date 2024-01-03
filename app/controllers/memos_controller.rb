class MemosController < ApplicationController
  before_action :set_memo, only: [:edit,:update,:destroy]

  def index
    @q = Memo.ransack(params[:q])
    @memos = @q.result(distinct: true).includes(:user).page(params[:page]).order("created_at desc")
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      redirect_to user_memos_path(current_user),  notice: "メモを作成しました"
    else
      flash.now[:alert] = @memo.errors.full_messages
      render :new
    end
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def edit ;end

  def update
    if @memo.update(memo_params)
      redirect_to user_memos_path(current_user), notice: "メモを編集しました"
    else
      flash.now[:alert] = @memo.errors.full_messages
      render :edit
    end
  end

  def destroy
    @memo.destroy!
    redirect_to user_memos_path, notice: "メモを削除しました"
  end


  private

  def memo_params
    params.require(:memo).permit(:name, :goods, :time, :user_id)
  end

  def set_memo
    @memo = current_user.memos.find(params[:id])
  end
end