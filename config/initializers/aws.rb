Aws.config.update({
  region: 'ap-northeast-1',
  credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id], Rails.application.credentials.aws[:secret_access_key]),
})