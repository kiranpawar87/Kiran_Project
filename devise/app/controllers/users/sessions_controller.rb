class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
  def create


    p "resource ----- #{self.resource.inspect}"
    # self.resource = warden.authenticate!(auth_options)
    super
    p "resource ----- #{resource.inspect}"
    # set_flash_message(:notice, :signed_in) if is_navigational_format?
    # sign_in(resource_name, resource)
    # if !session[:return_to].blank?
    #   redirect_to "users/admin_page"
    #   session[:return_to] = nil
    #   @uname=params[:user][:email]
    #   @pass=params[:user][:password]
    #
    #    @row=User.find_by_email(@uname)
    #
    #      @type=@row.utype.split(": ")
    #      @type=@type[@type.length-1].downcase().match("user") || @type[@type.length-1].downcase().match("admin")
    #      if @type[0]=="admin"
    #   #      Devise::sign_in(resource,resource_name)
    #        redirect_to :controller=>"/users",:action=>"admin_page"
    #        return
    # else
    #    # respond_with resource, :location => after_sign_in_path_for(resource)
    #   redirect_to :controller=>"/users",:action=>"user_page"
    #   return
    # end
    # @uname=params[:user][:email]
    # @pass=params[:user][:password]
    #
    # @row=User.find_by_email(@uname)
    # if(@uname.blank? || @pass.blank? || @row.blank?)
    #   super
    # elsif(@row.valid_password?(@pass))
    #
    #   @type=@row.utype.split(": ")
    #   @type=@type[@type.length-1].downcase().match("user") || @type[@type.length-1].downcase().match("admin")
    #   if @type[0]=="admin"
    #      Devise::sign_in(resource,resource_name)
    #     redirect_to :controller=>"/users",:action=>"admin_page"
    #     return
    #   else
    #     redirect_to :controller=>"/users",:action=>"user_page"
    #     return
    #   end
    # else
    #   # redirect_to :controller=>"users/sessions",:action=>"new"
    #   # return
    #   super
    #   # flash[:alert] = "Incorrect username or password"
    #
    #
    # end
  end
  def destroy
    super
         # redirect_to :controller=>"users/sessions",:action=>"new"
  end
end
