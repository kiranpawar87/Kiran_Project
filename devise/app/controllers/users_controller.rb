class UsersController < ApplicationController
  require 'net/smtp'
  def admin_page
     if user_signed_in?
         @me = current_user.id
       @cur_user = User.find(@me)
       @type=@cur_user.utype.split(": ")
       @type=@type[@type.length-1].downcase().match("user") || @type[@type.length-1].downcase().match("admin")
       if @type[0]=="admin"

        @cat=Category.all
        @source1="view_sub_cat"
        @act=params[:name]
        p @act
        if(@act=="Manage")
          @source="manage_users"
        elsif(@act=="user_stat")
          @source="user_stat"
        elsif(@act=="Search")
          @source="manage_users"
        else
          @source="manage_users"
        end
        else
         redirect_to :controller=>"users",:action=>"user_page"
       end
     else
       flash[:Error]="You are not a valid user"
       # redirect_to "/login"
     end
  end
  def user_page
    @user=current_user.id
    @wins=User.find(@user).wins
    @lose=User.find(@user).lose
    @abc="Comments"
    @abc=Category.all
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
  def found_users
    @state="show"                                             #table division showing
    @title="Users Found"                                       #title to divisio
  end
  def manage_users
    @users=User.all
    @size=@users.size
    @state="show"
    @title="Manage Users"
    p "title #{@title}"
    render "/users/view_users"
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

    flash[:success]=""
    if(!params[:uid].blank?)

      @row = User.find(params[:uid])

      if @row.blank?
        flash[:Error]="User id doesn't exist"
      else
        @row.update_attribute(:fname, params[:fname])
        @row.update_attribute(:lname, params[:lname])
        @row.update_attribute(:email, params[:email])


        @utype=params[:utype]

        if @row.update_attribute(:utype, params[:utype])
          @state="show"                                             #table division showing
          @title="View Users"                                       #title to division
          @users=User.all
          @size=@users.size
          flash[:success]="Record successfully updated"
          render "users/view_users"
        else
          flash[:Error]="Record not updated"
          render "users/edit_record"
        end
      end
    elsif params[:uname]=="Update"
      @rec=Category.find(session[:cat_id])
      # @cat_id=@rec.id
      @row.update_attribute(:cat_name, params[:cat_name])
      # @row.update_attribute(:lname, params[:lname])
      # @row.update_attribute(:email, params[:email])

    else
      @flag=0;
      @cat_name=params[:cat_name]
      @row=Category.new(:cat_name=>@cat_name)
      @row.save
      if !@row.save
        flash[:Error]=@row.errors.first
      else

        @arr=params[:sub_cat_name].split(",")
        @arr.each do |i|
          @row1=@row.sub_categories.new(:scat_name=>i)
          @row1.save
          if !@row1.save
            flash[:error]=@row1.errors.first
            @flag=0
            break
          else
            @flag=1
          end
        end
        if @flag==1
          flash[:success]="Record Successfully inserted"
        end
      end

        @cat=Category.all
        @category=Category.new
        @state="show"
        @title="Add Category"
        render "users/add_category"
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
    @users=User.where(:fname=>@fname)
    @users1=User.where(:lname=>@lname)
    @users=(@users+@users1).uniq
    @size=@users.size
    if(@users.nil?)
      @title="No record Found"
      @size=0
    end
    render "users/found_users"
  end
  def add_category
    set



    # msg = "Subject: Hi There!\n\nHi kaushik.....This is a mail from kiran pawar."
    # smtp = Net::SMTP.new 'smtp.gmail.com', 587
    # smtp.enable_starttls
    #
    # smtp.start("smtp.gmail.com","mailtotest97@gmail.com", "testingmail", :login) do
    #   @abc=smtp.send_message(msg, "mailtotest97@gmail.com", "kiran@iternia.com")
    #   p @abc
    # end


    @cat=Category.all
    @sub_cat_rec=SubCategory.new
    @category=Category.new
    # @sub_cats_rec=""
    @source1="view_sub_cat"

  end
  def view_sub_cat
    @id=session[:viewId]
    @selected_cat=Category.find(@id).cat_name
    @sub_cats=SubCategory.find_all_by_category_id(@id)
    @category=Category.all
  end
  def view
    @id=params[:name]
    session[:viewId]=params[:name]
    @source1="view_sub_cat"
      set
     @cat=Category.all
     @category=Category.new

    render "users/add_category"
  end
  def delete_category
    @id=params[:name]
    session[:viewId]=params[:name]
    set

    SubCategory.where(category_id: @id ).destroy_all
    Category.find(@id).destroy

    render "users/add_category"
  end
  def update_category
    set
    session[:cat_id]=params[:name]
    @action="update_record"
    @category=Category.find(params[:name])
    @sub_cat_re=SubCategory.where(:category_id=>params[:name])
    @sub_cats_rec=""
    @array=[]
    @cnt=0
    @sub_cat_re.each do |i|
      @sub_cats_rec+=i.scat_name+","
      @array[@cnt]=i.id
      @cnt=@cnt+1
    end
    session[:sub_ids]=@array
    render "users/add_category"
  end
  def set
    @action="save_record"
    @source1="view_sub_cat"
    @state="show"
    @title="Add Category"
    @cat=Category.all
    @category=Category.new
  end
  def update_record
    set
    @id=session[:cat_id]
    @row=Category.find(@id)
    @row.update_attribute(:cat_name,params[:cat_name])
    @arr=params[:sub_cat_name].split(",")
    @sub_ids_array=session[:sub_ids]

    @cnt=0
    @arr.each do |i|

      @rw=SubCategory.find(@sub_ids_array[@cnt])
      @rw.update_attribute(:scat_name,i)
      @cnt=@cnt+1
    end
    render "users/add_category"
  end
  def change_pass

  end
  def reset_pass
    set
    @oldPass=params[:old_pass]
    @newPass=params[:new_pass]
    @cPass=params[:c_pass]
    @rw=User.find(current_user.id)
    @rw.update_attribute(:password,@newPass)
    render "users/add_category"
  end
  def index
    # render "devise/sessions/destroy"
  end

end

