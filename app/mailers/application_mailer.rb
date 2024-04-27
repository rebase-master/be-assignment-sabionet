# frozen_string_literal: true

# Class to handle mailing
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
