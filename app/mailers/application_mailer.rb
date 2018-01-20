class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@blog.com'
  layout 'mailer'
end
