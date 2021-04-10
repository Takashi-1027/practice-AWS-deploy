class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    @word  = params[:word]

    if @range == '1'
      if search == "perfect_much"
        @user = User.where("name like?", "#{@word}")
      elsif search  == "forward_mach"
        @user = User.where("name like?", "#{@word}%")
      elsif search  == "backward_mach"
        @user = User.where("name like?", "%#{@word}")
      elsif search  == "pertical_mach"
        @user = User.where("name like?", "%#{@word}%")
      else
        @user = User.all
      end
    else
      if search == "perfect_much"
        @book = Book.where("title like?", "#{@word}")
      elsif search == "forward_mach"
        @book = Book.where("title like?", "#{@word}%")
      elsif search == "backward_mach"
        @book = Book.where("title like?", "%#{@word}")
      elsif search == "pertical_mach"
        @book = Book.where("title like?", "%#{@word}%")
      else
        @book = Book.all
      end
    end
  end
end
