class GiftSuggestion < ApplicationRecord
  belongs_to :user
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :business, presence: true, length: { maximum: 20 }
  validates :hobby, presence: true, length: { maximum: 20 }
  validates :interest, presence: true, length: { maximum: 20 }
  validates :purpose, presence: true, length: { maximum: 20 }
  validates :relationship, presence: true, length: { maximum: 20 }
  validates :gender, presence: true
  enum gender: { man: 0, woman: 1, other: 2 }

  def get_suggestion
    client = OpenAI::Client.new(access_token: Rails.application.credentials.API_KEYS[:OPENAI_API])
    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: '以下の情報に基づいてギフト提案(商品名を一つ、理由などを述べずに商品名だけ)を行ってください' },
          { role: 'user', content: format_input }
        ]
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  def format_input
    "年齢: #{age}, 性別: #{gender}, 職業: #{business}, 趣味: #{hobby}, 興味: #{interest}, プレゼントの目的: #{purpose}, 関係性: #{relationship}"
  end
end
