class UsersController < ApplicationController
  def admin_page
    @act=params[:name]
    if(@act=="Manage")
      @source="users/manage_users"
    elsif(@act=="user_stat")
      @source="users/user_stat"
    elsif(@act=="Search")
      @source="users/manage_users"
    else
      @source="users/user_page"
    end
  end

  def user_page
  end

  def new
    @users=User.all
    redirect_to :controller=>"users",:action=>"index"
  end
  def view_users
    @state="show"                                             #table division showing
    @title="View Users"                                       #title to division
    @users=User.all
    @size=@users.size
  end
  def manage_users
    @users=User.all
    @size=@users.size
    @state="show"
    @title="Manage Users"
    render "users/view_users"
  end
  def edit_record
    @id=params[:name]
    @state="hide"
    @source="users/view_users"
    @users=User.find(@id)
    @title="Edit Users"

     # render "users/view_users"
  end
  def save_record

    @row = User.find(params[:uid])

    if @row.blank?
      flash[:Error]="User id doesn't exist"
    else
      @row.update_attribute(:fname, params[:fname])
      @row.update_attribute(:lname, params[:lname])
      @row.update_attribute(:email, params[:email])


    @utype=params[:utype]
      flash[:notice]=@utype
     if @row.update_attribute(:utype, params[:utype])
       @state="show"                                             #table division showing
       @title="View Users"                                       #title to division
       @users=User.all
        render "users/view_users"
     else
       flash[:Error]="Record not updated"
       render "users/edit_record"
     end
    end
  end
  def user_stat
    @state="show"                                             #table division showing
    @title="User Statistic"                                       #title to division
    @users=User.all
  end
  def search
    @state="show"                                             #table division showing
    @title="Users Found"                                       #title to division
    # @users=User.find_by_email(params[:uname])
    @full_name=params[:uname].split(" ")
    @fname=@full_name[0]
    @lname=@full_name[1]
    @users=User.find_all_by_fname(@fname)
    @users+=User.find_all_by_lname(@lname)
    @size=@users.size
    if(@users.nil?)
      @title="No record Found"
      @size=0
    end
    render "users/view_users"
  end
end

