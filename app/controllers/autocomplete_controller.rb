class AutocompleteController < ApplicationController
  def business
    query = params[:q]
    businesses = GiftSuggestion.where('business LIKE ?', "%#{query}%").distinct.pluck(:business)
    html = businesses.map { |business| 
      "<li role='option'>#{business}</li>"
    }.join('')
  
    render html: html.html_safe
  end
  

  def interest
  
  end

  def relationship
    
  end

  def purpose
 
  end
end
