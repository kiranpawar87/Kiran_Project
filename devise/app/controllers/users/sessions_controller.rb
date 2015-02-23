class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
  def create
    @uname=params[:user][:email]
    @pass=params[:user][:password]

    @row=User.find_by_email(@uname)
    if(@uname.blank? || @pass.blank? || @row.blank?)
      super
    elsif(@row.valid_password?(@pass))
      redirect_to :controller=>"/users",:action=>"admin_page"
    else
      # redirect_to :controller=>"users/sessions",:action=>"new"
      # return
      super
      # flash[:alert] = "Incorrect username or password"


    end
  end
  def destroy
    super
         # redirect_to :controller=>"users/sessions",:action=>"new"
  end
end
