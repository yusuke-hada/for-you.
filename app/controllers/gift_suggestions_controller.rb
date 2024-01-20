require 'openai'
require 'rakuten_web_service'
class GiftSuggestionsController < ApplicationController
  def index
    @gift_suggestions = current_user.gift_suggestions.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    @gift_suggestion = build_gift_suggestion

    if @gift_suggestion.valid?
      process_gift_suggestion
    else
      flash.now[:alert] = @gift_suggestion.errors.full_messages
      render :new
    end
  end

  def show
    @gift_suggestion = GiftSuggestion.find(params[:id])
    @items = RakutenWebService::Ichiba::Item.search(keyword: @gift_suggestion.result, hits: 3)
  end

  def destroy
    gift_suggestion = current_user.gift_suggestions.find(params[:id])
    gift_suggestion.destroy!
    redirect_to user_gift_suggestions_path(current_user), alert: t('.success'), status: :see_other
  end

  private

  def build_gift_suggestion
    current_user.gift_suggestions.build(gift_suggestion_params.except(:hobbies)).tap do |gift_suggestion|
      gift_suggestion.hobbies = split_hobby(gift_suggestion_params[:hobbies])
    end
  end

  def process_gift_suggestion
    @gift_suggestion.result = @gift_suggestion.generate_suggestion

    if @gift_suggestion.save
      redirect_to user_gift_suggestion_path(current_user, @gift_suggestion)
    else
      flash.now[:alert] = @gift_suggestion.errors.full_messages
      render :new
    end
  end

  def gift_suggestion_params
    params.require(:gift_suggestion).permit(
      :age, :gender, :business, :interest,
      :purpose, :relationship, :user_id, :hobbies
    )
  end

  def split_hobby(hobby_str)
    return [] if hobby_str.nil?

    hobby_str.split(/[,、・]/).reject(&:empty?)
  end
end
