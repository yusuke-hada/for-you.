namespace :anniversary do
  desc "登録された記念日のうち一ヶ月前、二週間前、１週間前、当日に通知を送信"
  task send_anniversary_notifications: :environment do
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_SECRET]
      config.channel_token = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_TOKEN]
    }
    today = Date.today
  
    Anniversary.find_each do |anniversary|
      days_until_anniversary = (anniversary.date - today).to_i
      puts "Sending anniversary for #{anniversary.title}"
      message_text = case days_until_anniversary
                     when 30
                       "#{anniversary.title}1ヶ月前です!プレゼントの準備はできていますか？"
                     when 14
                       "#{anniversary.title}2週間前です!何をしようか考えましたか？"
                     when 7
                       "#{anniversary.title}1週間前です!"
                     when 0
                       "今日は#{anniversary.title}です！おめでとうございます！"
                     else
                       nil
                     end
      
      if message_text
        message = {
          type: 'text',
          text: message_text
        }
        response = client.push_message(anniversary.user.line_uid, message)
        puts response
        # 以下エラーハンドリングを追加する
      end
    end
  end
end  