class Users::PasswordsController <Devise::PasswordsController
  require 'net/smtp'
  def new
    self.resource = resource_class.new
    super
  end
  def create
    @mailid=params[:user][:email]
    @subject="Reset your password"
    @to=@mailid
    @from="kingkiran.pawar@gmail.com"

    # send_email @mailid, :body => "This was easy to send"
#     msg = <<END_OF_MESSAGE
#     From: #{@from}
#     To: <#{@to}>
#     Subject: #{@subject}
#
#     "password reset"
# END_OF_MESSAGE
#
#     Net::SMTP.start('localhost') do |smtp|
#
#       smtp.send_message msg, @from, @to
#     end

    super
  end
  def edit
    super
  end
end
