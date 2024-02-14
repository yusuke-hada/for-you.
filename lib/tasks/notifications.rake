namespace :notifications do
  desc "登録された記念日のうち一ヶ月前、二週間前、１週間前、当日に通知を送信"
  task send_anniversary_notifications: :environment do
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_SECRET]
      config.channel_token = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_TOKEN]
    }
    today = Date.today
  
    Anniversary.find_each do |anniversary|
      days_until_anniversary = (anniversary.date - today).to_i
      puts "Sending notification for #{anniversary.title}"
      message_text = case days_until_anniversary
                     when 30
                       "1ヶ月前です！#{anniversary.title}の準備はできていますか？"
                     when 14
                       "2週間前です！#{anniversary.title}に何をしようか考えてみましょう。"
                     when 7
                       "1週間前です！#{anniversary.title}が近づいています。"
                     when 0
                       "今日は#{anniversary.title}です！お祝いを忘れずに。"
                     else
                       nil # 通知する必要がない日
                     end
      
      if message_text
        message = {
          type: 'text',
          text: message_text
        }
      
        # ここでLINEユーザーIDを指定してメッセージを送信します
        # LINEユーザーIDは、ユーザーがボットと友だちになったときに取得できます
        response = client.push_message(anniversary.user.line_user_id, message)
        puts response
      end
    end
  end
end  