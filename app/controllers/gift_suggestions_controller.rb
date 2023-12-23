require 'openai'
class GiftSuggestionsController < ApplicationController
  def index
    @gift_suggestions = current_user.gift_suggestions
  end

  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    @gift_suggestion = current_user.gift_suggestions.build(gift_suggestion_params.except(:hobbies))
    @gift_suggestion.hobbies = split_hobby(gift_suggestion_params[:hobbies])

    unless @gift_suggestion.valid?
      flash.now[:alert] = @gift_suggestion.errors.full_messages
      return render :new
    end

    @gift_suggestion.result = @gift_suggestion.get_suggestion

    if @gift_suggestion.save
      redirect_to user_gift_suggestion_path(current_user, @gift_suggestion)
    else
      flash.now[:alert] = @gift_suggestion.get_suggestion
      render :new
    end
  end

  def show
    @gift_suggestion = GiftSuggestion.find(params[:id])
  end

  private

  def gift_suggestion_params
    params.require(:gift_suggestion).permit(:age, :gender, :business, :interest, :purpose, :relationship, :user_id, :hobbies)
  end

  def split_hobby(hobby_str)
    return [] if hobby_str.nil?

    hobby_str.split(/[,、・]/).reject(&:empty?)
  end
end
