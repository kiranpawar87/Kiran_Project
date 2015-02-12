class HangmanController < ApplicationController
 include GameHelper
  @cnt=0
  def index

    @posts = UserInfo.new
    session.clear
  end

  def create

    # <%=text_field_tag 'fname',nil,:placeholder=>'First Name'%>&nbsp;&nbsp;&nbsp;
    # <%=text_field_tag 'lname',nil,:placeholder=>'Last Name'%><br><br>
    # <%=email_field_tag 'email',nil,:placeholder=>'Email Id'%><br><br>
    @btn=params[:name]
    if params[:name]=="cancel"
      redirect_to :controller=>:hangman, :action=>:index
      return
    else
      @fname=params[:fname]
      @lname=params[:lname]
      @uname=params[:email]
      @pass=params[:pass]
      if(@pass==params[:c_pass])
        @posts=UserInfo.new(:fname=>@fname,:lname=>@lname,:uname=>@uname,:pass=>@pass)#,:wins=>"0",:lose=>"0")
        @posts.save
        if !@posts.save
          flash[:error]=@posts.errors.full_messages.first
        else

          redirect_to :controller=>:hangman, :action=>:index
          return
        end
        render "hangman/index"
      end
    end
  end

  def game

    @btn="hide_btn"
    @input="inputVal_hide"

    if(session[:uname].blank?)
      redirect_to :controller=>:hangman, :action=>:Error
      return
    end

    @cat=Category.all
    @newGame=""


    @c_name="Select category first"

    @user=session[:uname]

    @hangImage="hang0.gif"
    @activeUser=UserInfo.all(:conditions => { :uname => @user})
    @wins="Wins : "+@activeUser[0].wins.to_s()
    @lose="Lose : "+@activeUser[0].lose.to_s()
    session[:user_id]=@activeUser[0].id.to_i()
    session[:wins]=@activeUser[0].wins.to_s()
    session[:lose]=@activeUser[0].lose.to_s()


  end

  def login
     @posts=UserInfo.new
    @uname=params[:username]
    @passwd=params[:password]

    # @row=UserInfo.all(:conditions => { :uname => @uname, :pass=>@passwd })
    @row = UserInfo.where(:uname => @uname, :pass => @passwd).first

    # if(@row.length==0)
    if(@row.blank?)
      flash[:error]="Wrong username or password"
    else
      session.clear
      session[:uname]=@uname
      redirect_to :controller => :hangman,:action => :set
      return
    end
    render "hangman/index"

  end
  def set
    #session initialization

    session[:cnt]=0
    session[:firstFlag]=0                                                     #flag to check first time
    @word=Array.new()
    session[:word]=@word
    session[:pos]=0

    @wrongWords=""
    session[:wrongWords]=@wrongWords


    @user=session[:uname]
    r=Random.new
    @num = r.rand(1...9)
    session[:num]=@num
    session[:wrongAttempt]=1
    @cat=Category.all
    session[:hangImage]="hang0.gif"
    redirect_to :controller => :hangman,:action => :game
    return
  end
  def reset
    @btn="show_btn"
    @input="inputVal"
    if(session[:uname].blank?)
      redirect_to :controller=>:hangman, :action=>:Error
      return
    end

    flash[:success]=""
    @newGame=""
    @hangImage="hang0.gif"

    session["wrongWords"]=""
    @user=session[:uname]
    @cat=Category.all
    @word=Array.new()
    session[:word]=@word
    r=Random.new
    @num = r.rand(1...9)
    session[:num]=@num
    session[:wrongAttempt]=1

    @wins="Wins : #{session[:wins]}"
    @lose="Lose : #{session[:lose]}"


    if(params[:name])
      @name=params[:name]

      session[:category]=@name
    else
      @name=session[:category]
    end
    @c_name=Category.find(@name).cat_name
    session[:cat_id]= Category.find(@name).id
    session[:cat_name]=Category.find(@name).cat_name
    session[:firstFlag]=0;

    @targetWord=Noun.all(:conditions=>{:category_id=>session[:cat_id],:id=>(10*(session[:cat_id].to_i()-1))+@num.to_i()})
    @targetWord=@targetWord[0].name.upcase
    @len=@targetWord.length

    @i=0
    while @i<@len && session[:firstFlag]==0

      @word[@i]="-"
      @i=@i+1
    end

    @hangImage="hang0.gif"
    render "hangman/game"
  end

  def wordFormed



    if(session[:uname].blank?)
      redirect_to :controller=>:hangman, :action=>:Error
      return
    end
    @input="inputVal"
    #reseting messages
    flash[:success]=""
    @newGame=""

    @cat=Category.all
    @c_name=session[:cat_name]
    @user=session[:uname]
    # @targetWord=Noun.all(:conditions=>{:category_id=>session[:cat_id],:id=>(10*(session[:cat_id].to_i()-1))+session[:num].to_i()})
    @targetWord=Noun.where(:category_id=>session[:cat_id],:id=>(10*(session[:cat_id].to_i()-1))+session[:num].to_i())
    @targetWord=@targetWord[0].name.upcase
    @len=@targetWord.length
    @cnt=session[:cnt]
     @value=params[:inputVal].upcase
    
    @word=session[:word]
    @i=0;
    @wrongAttempt=session[:wrongAttempt]
    @hangImage=session[:hangImage]
    @wins="Wins : "+session[:wins].to_s()
    @lose="Lose : "+session[:lose].to_s()
    @checkExists=session[:wrongWords].split(" ")                   #string of 'wrong attemps' is split and stored in array
    @executeFlag=0

    #A letter should be typed once for one word
    @i=0
    while true
      if @i<@checkExists.length                           #initially i and checkExists are same
        if @checkExists[@i]==@value
          flash[:success]="A letter should use at once"
          @executeFlag=0
          break
          else
          @executeFlag=1
        end
          @i=@i+1

        else
          @executeFlag=1
          break
      end

    end

    #adding dash(-) in an array
    @i=0
    while @i<@len && session[:firstFlag]==0
      @word[@i]="-"
      @i=@i+1
    end

    session[:firstFlag]=1
    @i=0
    @match=0

    if @wrongAttempt<=10

      if !(@value.blank?) &&(@value.length==1 || @value.length==@targetWord.length)            #input value should either a single letter or whole word
        if @executeFlag==1
          #matching words
          if @value.length==1                                                                         #if input is single letter
            while @i<=@len

              if @targetWord[@i]==@value
                @word[@i]=@value
                if(@targetWord[@i+1]==@value)
                  @word[@i+1]=@value
                end

                @i=@i+1
                @match=1
                session[:backup]=@btn
                session[:cnt]=@cnt
              else
                @cnt=@cnt+1
              end
              @i=@i+1

            end
          else if @value==@targetWord                                                          #if input is whole letter
                  @i=0
                  @val=@value.split("")
                  while @i<@value.length
                   @word[@i]=@val[@i]
                   @match=1
                  @i=@i+1
                  end

               end

          end
          if(@match==0)
            session[:wrongAttempt]=session[:wrongAttempt]+1
            @hangImage="hang"+@wrongAttempt.to_s()+".gif"
            session[:wrongWords]=session[:wrongWords]+@value+" "
            session[:pos]=session[:pos].to_i()+1
          end

          #checking whether word is completed or not
          @i=0
          @completeFlag=0
          while @i<@word.length
            if @word[@i]!="-"
              @completeFlag=1
            else
              @completeFlag=0
              break
            end
            @i=@i+1
          end
          @wrongWords="Wrongs Attempts : #{session[:wrongWords]}"
          @attempts="Attempts Remained : #{12-session[:wrongAttempt]}"
          if @completeFlag==1
            flash[:success]="Congratulation!! You won."
            session[:wins]=session[:wins].to_i()+1
            @record=UserInfo.update(session[:user_id], :wins =>session[:wins])
            @record.save

            @newGame="New Game"
          end
          session[:word]=@word
        else
          flash[:success]="A letter sholud typed once"
        end
      else
        flash[:success]="Enter Correct word"
      end


    else
        flash[:success]="Sorry! You are failed"
        session[:lose]=session[:lose].to_i()+1
        @record=UserInfo.update(session[:user_id], :lose =>session[:lose])
        @record.save

        @failed="The correct word is #{@targetWord}"
        @newGame="New Game"
    end
    session[:hangImage]=@hangImage
    render "hangman/game"
  end
  def Error

  end
end
