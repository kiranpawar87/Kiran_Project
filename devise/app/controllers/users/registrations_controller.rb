class Users::RegistrationsController <Devise::RegistrationsController

  def new
    super
    @posts="new"
  end
  def create
     # super
    # @posts=User.new(:fname=>@fname,:lname=>@lname,:email=>@email,:uname=>@uname,:password=>@pass)#,:wins=>"0",:lose=>"0",:utype=>"User")
    @fname=params[:user][:fname]
    @lname=params[:user][:lname]
    @email=params[:user][:email]
    @uname=params[:user][:uname]
    @pass=params[:user][:password]
   @posts=User.new(:fname=>@fname,:lname=>@lname,:email=>@email,:uname=>"",:password=>@pass,:wins=>'0',:lose=>'0',:utype=>"user")
  @posts.save
     if !@posts.save
       @posts=User.new
       super
     else

       signed_in_resource#(resource_name, resource)
       msg = "Subject: Sign up to hangman\n\nHi #{@fname} #{@lname},\n\n\tThanks for signing up to hangman."
       smtp = Net::SMTP.new 'smtp.gmail.com', 587
       smtp.enable_starttls

       smtp.start("smtp.gmail.com","mailtotest97@gmail.com", "testingmail", :login) do
         @abc=smtp.send_message(msg, "mailtotest97@gmail.com", @email)
         p @abc
       end

       flash[:notice]="Thanks for sign up.We have sent you a mail."

       redirect_to "/login"
       return


     end
  end
  def destroy
    super
  end
end
