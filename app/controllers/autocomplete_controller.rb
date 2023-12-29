class AutocompleteController < ApplicationController
  def business
    query = params[:term]
    suggestions = GiftSuggestion.where('business LIKE ?', "%#{query}%").distinct.limit(10)
    render json: suggestions.map { |suggestion| { label: suggestion.business } }
  end

  def interest
  
  end

  def relationship
    
  end

  def purpose
 
  end
end
