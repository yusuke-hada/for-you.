namespace :anniversary do
  desc '登録された記念日のうち一ヶ月前、二週間前、１週間前、当日に通知を送信'
  task send_anniversary_notifications: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_SECRET]
      config.channel_token = Rails.application.credentials.line_messaging_api[:LINE_CHANNEL_TOKEN]
    end
    today = Date.today

    Anniversary.find_each do |anniversary|
      days_until_anniversary = (anniversary.date - today).to_i
      puts "Sending anniversary for #{anniversary.title}"
      message_text = case days_until_anniversary
                     when 28
                       "#{anniversary.date}#{anniversary.title}まで1ヶ月です!プレゼントの準備はできていますか？\n#{anniversary.description}\nhttps://www.present-for-you.jp"
                     when 14
                       "#{anniversary.date}#{anniversary.title}まで2週間です!何をしようか考えましたか？\n#{anniversary.description}\nhttps://www.present-for-you.jp"
                     when 7
                       "#{anniversary.date}#{anniversary.title}まで1週間です!プレゼントが決まってなかったらfor youで急いで準備しましょう！\n#{anniversary.description}\nhttps://www.present-for-you.jp"
                     when 0
                       "#{anniversary.date}今日は#{anniversary.title}です！おめでとうございます！\n#{anniversary.description}\nhttps://www.present-for-you.jp"
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
