ActionMailer::Base.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: 587,
  user_name: CONFIG[:mandrill_username],
  password: CONFIG[:mandrill_api_key],
  domain: CONFIG[:host]
}
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = CONFIG[:mandrill_api_key]
end
