# [config/initializers/setup_mail.rb]

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "xuncheng.net",
  :user_name            => "noreply",
  :password             => "<password>",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
