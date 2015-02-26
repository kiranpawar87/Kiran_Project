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
       super
     else
       signed_in_resource#(resource_name, resource)
       redirect_to "/login"
       return
     end
  end
  def destroy
    super
  end
end
