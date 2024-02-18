class AnniversariesController < ApplicationController
  before_action :set_anniversary, only: %i[edit update destroy]

  def index
    @q = current_user.anniversaries.ransack(params[:q])
    @anniversaries = @q.result(distinct: true)
                       .includes(:user)
                       .page(params[:page])
                       .order('created_at desc')
                       .per(10)
  end

  def new
    @anniversary = Anniversary.new
  end

  def create
    @anniversary = current_user.anniversaries.build(anniversary_params)
    if @anniversary.save
      redirect_to anniversaries_path, notice: t('.success')
    else
      flash.now[:alert] = @anniversary.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @anniversary.update(anniversary_params)
      redirect_to anniversaries_path, notice: t('.success')
    else
      flash.now[:alert] = @anniversary.errors.full_messages
      render :edit
    end
  end

  def destroy
    @anniversary.destroy!
    redirect_to anniversaries_path, alert: t('.success'), status: :see_other
  end

  private

  def anniversary_params
    params.require(:anniversary).permit(:title, :description, :date)
  end

  def set_anniversary
    @anniversary = current_user.anniversaries.find(params[:id])
  end
end
