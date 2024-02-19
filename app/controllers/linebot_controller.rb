class LinebotController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_SECRET]
      config.channel_token = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_TOKEN]
    end
  end

  def send_message(user_id, message)
    message_content = {
      type: 'text',
      text: message
    }
    @client.push_message(user_id, message_content)
  end
end
