# # Rails.application.config.action_mailer.tap do |action_mailer|
# Rails.application.configure do
#   if Rails.env.test?
#     config.action_mailer.default_url_options = {
#       host: "localhost"
#     }
#   elsif Rails.env.development?
#     config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
#     config.action_mailer.delivery_method = :smtp
#     action_mailer.perform_deliveries = true

#     config.action_mailer.tap do |action_mailer|
#       action_mailer.raise_delivery_errors = true
#       action_mailer.smtp_settings = {
#         address:              ENV.fetch("SMTP_SERVER") { 'localhost' },
#         port:                 ENV.fetch("SMTP_PORT") { 1025 },
#         domain:               ENV.fetch("SMTP_SERVER") { 'localhost' }
#       }
#     end
#   else
#     # ensure that the correct portocol is used when generating emails
#     protocal = Rails.application.config.force_ssl ? "https" : "http"

#     config.action_mailer.default_url_options = {
#       host: ENV["HOSTNAME"],
#       protocol: protocal
#     }

#     config.action_mailer.delivery_method = :smtp
#     config.action_mailer.tap do |action_mailer|
#       action_mailer.raise_delivery_errors = true
#       action_mailer.smtp_settings = {
#         address:              ENV["SMTP_SERVER"],
#         port:                 ENV["SMTP_PORT"],
#         user_name:            ENV["SMTP_USER_NAME"],
#         password:             ENV["SMTP_PASSWORD"],
#         authentication:       "plain",
#         enable_starttls_auto: true,
#         ssl:                  ENV["SMTP_PORT"].to_i == 465
#       }
#     end

#     openssl_verify_mode = ENV.fetch('SMTP_SSL_VERIFY_MODE', nil)
#     config.action_mailer.smtp_settings[:openssl_verify_mode] if openssl_verify_mode
#   end
# end
