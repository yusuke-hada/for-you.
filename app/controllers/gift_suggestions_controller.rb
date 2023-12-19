require 'openai'
class GiftSuggestionsController < ApplicationController
  def index
    if params[:question].present?
        client = OpenAI::Client.new(access_token: Rails.application.credentials.API_KEYS[:OPENAI_API])
        response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "system", content: "対象者の性別、年齢、趣味、職業、興味に基づいて、一つのギフトアイデア（商品名のみ）を教えてください"},
                { role: "user", content: params[:question] }
            ]
        })
        @answer = response.dig("choices", 0, "message", "content")
    end
  end

  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create ;end
end
