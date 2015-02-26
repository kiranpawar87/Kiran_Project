class GameController < ApplicationController
  def start_game
    @abc=Category.all
    @wordFormed=["W","O","R","D"]
    @wordFormed=@wordFormed.to_s()

    # @game=Category.new(:cat_name=>params[:Category][:name])
    # @game.save()

    respond_to do |format|
      # if @game.save()
        @abc=Category.all
        format.html{render "users/user_page",with=>@wordFormed}
        format.js
      # else
      #   format.html{ render :action=>"users/user_page"}
      #   format.js
      # end
    end
  end
end
