class LinebotController < ApplicationController
  require 'line/bot'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.LINE_CHANNEL_SECRET
      config.channel_token = Rails.application.credentials.LINE_CHANNEL_TOKEN
    end
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
        end
      end
    end

    head :ok
  end
end
