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
    query = params[:q]
  interests = GiftSuggestion.where('interest LIKE ?', "%#{query}%").distinct.pluck(:interest)
    html = interests.map { |interest| 
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{interest}</li>"
    }.join('')
  
    render html: html.html_safe
  end

  def relationship
    query = params[:q]
    relationships = GiftSuggestion.where('relationship LIKE ?', "%#{query}%").distinct.pluck(:relationship)
      html = relationships.map { |relationship| 
        "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{relationship}</li>"
      }.join('')
    
      render html: html.html_safe
  end

  def purpose
    query = params[:q]
    purposes = GiftSuggestion.where('purpose LIKE ?', "%#{query}%").distinct.pluck(:purpose)
      html = purposes.map { |purpose| 
        "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{purpose}</li>"
      }.join('')
    
      render html: html.html_safe
  end
end
