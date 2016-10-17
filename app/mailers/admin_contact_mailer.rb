class AdminContactMailer < MandrillMailer::MessageMailer
  default from: 'support@dropresume.com'

  def contact(admin_contact, host)
    body = <<-HTML
      <h2>#{admin_contact.title}</h2>
      <p>From: #{host}</p>
      <p>Contact person: #{admin_contact.name}</p>
      <p>Email Address: #{admin_contact.email}</p>
      <br/>
      <p>#{admin_contact.body}</p>
    HTML

    mandrill_mail subject: "User Contact from Dropresume (Category: #{admin_contact.category})",
                  to: Rails.env.development? ? 'tauhidul@bytelogistics.com' : 'hello@dropresume.com',
                  html: body,
                  important: true,
                  inline_css: true
  end
end
