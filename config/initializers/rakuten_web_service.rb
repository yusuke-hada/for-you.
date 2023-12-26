require 'rakuten_web_service'
RakutenWebService.configure do |c|
  c.application_id = Rails.application.credentials.API_KEYS[:RAKUTEN_APPLICATION_ID]
  c.affiliate_id = Rails.application.credentials.API_KEYS[:RAKUTEN_AFFILIATE_ID]
  c.debug = true
end
