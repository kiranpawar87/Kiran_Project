class GameController < ApplicationController
  #  $cnt=0
  # $wordForm=[]
  def start_game
    @id=current_user.id
    @abc=Category.all
    @i=0
    @flag=0
    # if($cnt<$len)
      @letter=params[:letterIp].upcase()
      @letter=@letter.to_s()
      if(!@letter.blank?)                                                           #blank letter
        if(@letter.match("[A-Za-z]*")[0]!="")                                       #valid letter
          @a=@letter.match("[A-Za-z]*")

          #  Letter is entered before or not                                        #existence of letter
          @enteredFlag=0

          $enteredWords.each do |ch|
            if ch.upcase()==@letter.upcase()
              @enteredFlag=0
              break
            else
              @error=""
              @enteredFlag=1
            end

          end
        if($enteredWords[0].nil?)
       #      $enteredWords[0]=@letter
             @enteredFlag=1
           end
          if(@enteredFlag==1)
            $enteredWords.append(@letter)
            if(@letter.length==1)
              while(@i<$len) do
                  if($targetWord[@i]==@letter)
                   $wordForm[@i]=@letter
                   @flag=2
                  else
                    if(@flag!=2)
                      @flag=1
                    end
                  end
                  @i=@i+1
              end
            else
              if(@letter.length==$len && @letter==$targetWord)
                $wordForm=@letter
              else
                @flag=1;
                @error="Invalid Word"
              end
            end
            if(@flag==1)
              $attempt=$attempt-1
              $invalidWords+=@letter+","

              $cnt=$cnt+1
            end

            # @i=0
            # if($wordForm[0]==nil)
            #   reset
            # end
            @i=0
            @completeFlag=0
            while @i<$len
              if $wordForm[@i]!="_"
                @completeFlag=1
              else
                @completeFlag=0
                break
              end
              @i=@i+1
            end

            if @completeFlag==1
              @success="Congratulation!! You won."

              @wins=User.find(@id).wins
              @lose=User.find(@id).lose
              @wins=@wins+1
              @rw=User.find(@id)
              @rw.update_attribute(:wins,@wins)
              $winFlag=1
            elsif $attempt<=0
              @error="Sorry,You Lose. Your attempts over. Correct word is : #{$targetWord}"
              @lose=User.find(current_user.id).lose
              @wins=User.find(current_user.id).wins
              @lose=@lose+1
              @rw=User.find(@id)
              @rw.update_attribute(:lose,@lose)
              $loseFlag=1
            end

            @wordFormed=$wordForm.to_s()
          # $cnt=$cnt+1
          else
            @error="Letter is already entered"
          end

        else
          @error="Enter Valid Letters only"
        end
      else
        @error="Blank spaces is not allowed"
      end
    # else
    #   @error="Sorry,You lose.\nCorrect Word is : #{$targetWord},#{$attempt}"
    #   $loseFlag=1
    #   # reset
    # end

    # reset
    @wordFormed=$wordForm.to_s()
    @hangImage="hang#{$cnt}.gif"
    respond_to do |format|
        @abc=Category.all
        format.html{render "users/user_page"}
        format.js
    end
  end
  def reset
    $enteredWords=Array.new

    $wordForm=Array.new
    @i=0
    $invalidWords=""
    $winFlag=0
    $loseFlag=0
    @error=""
    @success=""
    $attempt=5
     while(@i<$len)
      $wordForm[@i]="_"
      @i=@i+1
    end
    @wordFormed=$wordForm.to_s()

    $cnt=0
  end
  def set_category

      @id=params[:id]
      @num=Random.rand(1...9)
      @selected_cat=Category.find(@id)
      $selected_cat=@selected_cat[:cat_name]
      $targetWord=SubCategory.where(:category_id=>@id)[@num]
      $targetWord=$targetWord[:scat_name].upcase()
       $len=$targetWord.length

      reset
      respond_to do |format|
        @abc=Category.all
        format.html{render "users/user_page"}
        format.js
      end

  end
  def set_word

  end
  def new_game
    @num=Random.rand(1...9)
    @error=""
    @success=""
    @id=Category.find_by_cat_name($selected_cat)
    @id=@id[:id]
    $targetWord=SubCategory.where(:category_id=>@id)[@num]
    $targetWord=$targetWord[:scat_name].upcase()
    $len=$targetWord.length

    reset
    respond_to do |format|
      @abc=Category.all
      format.html{render "users/user_page"}
        format.js
    end
  end
end
