Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, Rails.application.credentials.line_login[:LINE_CHANNEL_ID], Rails.application.credentials.line_login[:LINE_CHANNEL_SECRET],
           scope: 'profile openid',
           prompt: 'consent',
           redirect_uri: 'https://localhost:3000/oauth/callback?provider=line'
end
