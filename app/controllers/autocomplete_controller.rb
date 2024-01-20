class AutocompleteController < ApplicationController
  def business
    query = params[:q]
    businesses = GiftSuggestion.where('business LIKE ?', "%#{query}%").distinct.pluck(:business)
    html = businesses.map do |business|
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{business}</li>"
    end.join('')

    render html: html.html_safe
  end

  def interest
    query = params[:q]
    interests = GiftSuggestion.where('interest LIKE ?', "%#{query}%").distinct.pluck(:interest)
    html = interests.map do |interest|
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{interest}</li>"
    end.join('')

    render html: html.html_safe
  end

  def relationship
    query = params[:q]
    relationships = GiftSuggestion.where('relationship LIKE ?', "%#{query}%").distinct.pluck(:relationship)
    html = relationships.map do |relationship|
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{relationship}</li>"
    end.join('')

    render html: html.html_safe
  end

  def purpose
    query = params[:q]
    purposes = GiftSuggestion.where('purpose LIKE ?', "%#{query}%").distinct.pluck(:purpose)
    html = purposes.map do |purpose|
      "<li class='hover:bg-blue-400 hover:text-white' role='option'>#{purpose}</li>"
    end.join('')

    render html: html.html_safe
  end
end
