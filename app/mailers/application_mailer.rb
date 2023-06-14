class ApplicationMailer < ActionMailer::Base
  default from: Proc.new { from_email },
          reply_to: Proc.new { reply_to_email }

  layout 'mailer'

  private

  def from_email
    @from_email = ConfigService.value('email_from_address') || ENV['PROGRAM_EMAIL'] || ENV['SMTP_USER_NAME']
  end

  def reply_to_email
    @reply_to_email = ConfigService.value('email_reply_to_address') || ENV['PROGRAM_EMAIL'] || ENV['SMTP_USER_NAME']
  end
end

