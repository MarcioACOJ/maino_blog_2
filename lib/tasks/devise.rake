namespace :devise do
  desc "Send welcome reset password instructions to all users.
  This will lockout all users until they reset their password."
  task send_welcome_reset_password_instructions_to_all_users: :environment do
    user_id = ENV['id']
    user = User.find(user_id)
    UserMailer.welcome_reset_password_instructions(user).deliver
    p user_id
  end
end