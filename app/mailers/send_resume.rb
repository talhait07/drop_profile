class SendResume < ActionMailer::Base
  def email_resume(from, to, subject, body)
    @sender = from
    @receiver  = to
    @body = body
    @subject = subject
    mail(to: @receiver, subject: @subject)
  end
end
