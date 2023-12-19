require 'openai'
class GiftSuggestionsController < ApplicationController
  def index
    @gift_suggestions = GiftSuggestion.new
  end

  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    @gift_suggestion = current_user.gift_suggestions.build(gift_suggestion_params)

    if @gift_suggestion.save
      @answer = @gift_suggestion.get_suggestion
      binding.pry
      redirect_to  user_gift_suggestion_path(current_user, @gift_suggestion)
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def show
    @gift_suggestion = GiftSuggestion.find(params[:id])
  end

  private

  def gift_suggestion_params
    params.require(:gift_suggestion).permit(:age, :gender, :business, :hobby, :interest, :purpose, :relationship, :user_id)
  end

end
