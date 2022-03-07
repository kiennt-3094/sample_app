class ApplicationMailer < ActionMailer::Base
  default from: ENV["HOST_EMAIL"]
  layout "mailer"
end
