class Users::PasswordsController <Devise::PasswordsController
  require 'net/smtp'

  def new
    self.resource = resource_class.new
    super
  end
  def create
    super
     self.resource = resource_class.send_reset_password_instructions(resource_params)

    p "resource token #{resource.reset_password_token}"
    p "I have used this #{$ab}"
    msg = "Subject: Reset Password\n\nHi #{self.resource[:fname]}, \n\n\tReset Your password.\n Click here to reset your password http://localhost:3000/users/password/edit?reset_password_token=#{$ab}"
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls

    smtp.start("smtp.gmail.com","mailtotest97@gmail.com", "testingmail", :login) do
      @abc=smtp.send_message(msg, "mailtotest97@gmail.com",resource[:email])
      p @abc.status
    end

  end
  def update
    super

    self.resource = resource_class.reset_password_by_token(resource_params)


  end
  def edit
   super
  end

end
