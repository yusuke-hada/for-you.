class GiftSuggestion < ApplicationRecord
  belongs_to :user
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :business, presence: true, length: { maximum: 20 }
  validates :hobbies, presence: true, length: { maximum: 20 }
  validates :interest, presence: true, length: { maximum: 20 }
  validates :purpose, presence: true, length: { maximum: 20 }
  validates :relationship, presence: true, length: { maximum: 20 }
  validates :gender, presence: true
  enum gender: { man: 0, woman: 1, other: 2 }

  def generate_suggestion
    client = OpenAI::Client.new(access_token: Rails.application.credentials.API_KEYS[:OPENAI_API])
    response = fetch_suggestion(client, format_input)
    response.dig('choices', 0, 'message', 'content')
  end

  def fetch_suggestion(client, input)
    client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: 
            '以下の情報に基づいてプレゼント提案(商品名を一つ、理由などを述べずに必ず商品名だけ、' \
            'ネットショップで購入出来る現実的なもの)を行ってください、提案には"「","」"を付けないでください' },
          { role: 'user', content: input }
        ]
      }
    )
  end

  def format_input
    [
      "#{GiftSuggestion.human_attribute_name(:age)}: #{age}",
      "#{GiftSuggestion.human_attribute_name(:gender)}: #{gender}",
      "#{GiftSuggestion.human_attribute_name(:business)}: #{business}",
      "#{GiftSuggestion.human_attribute_name(:hobbies)}: #{hobbies}",
      "#{GiftSuggestion.human_attribute_name(:interest)}: #{interest}",
      "#{GiftSuggestion.human_attribute_name(:purpose)}: #{purpose}",
      "#{GiftSuggestion.human_attribute_name(:relationship)}: #{relationship}"
    ].join(',')
  end
end
