class LineEventsController < ApplicationController
  require 'line/bot'
  skip_before_action :verify_authenticity_token

  def webhook
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Follow # 友達登録イベント
        user_id = event['source']['sub'] # LINEのユーザーIDを取得
        # ここでユーザーIDをアプリのユーザーアカウントに紐づける処理を行う
        token = extract_token_from_message(event.message['text'])
        user = User.find_by(line_token: token)
        if user && user.update(line_user_id: user_id) # LINEユーザーIDをアプリのユーザーアカウントに紐づける
          send_completion_message(user_id)
        end
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
end
