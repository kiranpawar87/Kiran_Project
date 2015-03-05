class HangmanController < ApplicationController


  def index
     @posts=User.new

   end
  def create
     @btn=params[:name]
     if params[:name]=="cancel"
       redirect_to :controller=>:hangman, :action=>:index
       return
     else
       @fname=params[:fname]
       @lname=params[:lname]
       @email=params[:email]
       @uname=params[:uname]
       @pass=params[:password]
       if(@pass==params[:c_pass])
         @posts=User.new(:fname=>@fname,:lname=>@lname,:email=>@email,:uname=>@uname,:password=>@pass)#,:wins=>"0",:lose=>"0",:utype=>"User")
         @posts.save
          if !@posts.save
           flash[:error]=@posts.errors.full_messages.first
          else
            flash[:error]="SUCCESSFULLY REGISTERED"
           redirect_to :controller=>:hangman, :action=>:index
           return
         end

       end
     end
     render "hangman/index"
  end
  def login
     @posts=User.new
    @uname=params[:username]
    @passwd=params[:password]

    # @row=User.all(:conditions => { :uname => @uname, :password=>@passwd })
    # @row = User.where(:uname => @uname, :password => @passwd).first

   @row=User.find_by_uname(@uname)
    # if(@row.length==0)
    if(!@row.blank?)
      if !@row.valid_password?(@passwd)
        flash[:error]="Wrong username or password"
      else
        if @row.utype=="Admin"
          session.clear
          session[:uname]=@uname
          redirect_to :controller => :hangman,:action => :admin_page
          return
        else
          session.clear
          session[:uname]=@uname
          redirect_to :controller => :hangman,:action => :user_game
          return
        end
      end
    else
      flash[:error]="Wrong username or password"
    end

    render "hangman/index"

  end
  def admin_page
    if user_signed_in?
      @sheets = current_user
    else
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
      @title="View Users"
      @tableVisibility="show"
      @users=User.all

  end
  def user_game
  end

  def manage_user

    render "hangman/admin_page"
  end
end