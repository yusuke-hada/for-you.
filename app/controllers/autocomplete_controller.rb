class AutocompleteController < ApplicationController
  def business
    query = params[:q]
    businesses = GiftSuggestion.where('business LIKE ?', "%#{query}%").distinct.pluck(:business)
    html = businesses.map { |business| 
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{business}</li>"
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
