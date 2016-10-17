class DeviseMailer < MandrillMailer::MessageMailer
  def reset_password_instructions(user, token, host='dropresume.com')
    body = <<-HTML
    <p>Hello #{ user.email }!</p>
    <p>Someone has requested a link to change your password. You can do this through the link below.</p>
    <p><a href='http://#{host}/users/password/edit?reset_password_token=#{token}'>Change my password</a></p>
    <p>If you didn't request this, please ignore this email.</p>
    <p>Your password won't change until you access the link above and create a new one.</p>
    HTML
    mandrill_mail subject: 'Change Password request',
                  to: user.email,
                  from: "no-reply@#{host}",
                  from_name: 'No Reply',
                  html: body,
                  important: true,
                  inline_css: true
  end

  def confirmation_instructions(user, token)
    Rails.logger.info "Email Confirmation Token: #{token}"
    body = <<-HTML
    <p>Welcome #{user.full_name}!</p>
    <p>You can confirm your account email through the link below:</p>
    <p><a href='http://#{user.default_site}/users/confirmation?confirmation_token=#{token}'>Confirm my account</a></p>
    HTML
    mandrill_mail subject: 'Email Confirmation',
                  to: user.email,
                  from: "no-reply@#{user.default_site}",
                  from_name: 'No Reply',
                  html: body,
                  important: true,
                  inline_css: true
  end
end
