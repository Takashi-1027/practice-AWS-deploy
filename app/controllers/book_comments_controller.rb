class BookCommentsController < ApplicationController
  before_action :ensure_correct_book_comment, only: [:destroy]


  def create
    @book = Book.find(params[:book_id])
    @new_book_comment = BookComment.new
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    unless comment.save
      render "error"
    end
  end
  #   if comment.save
  #     redirect_to book_path(book)
  #   else
  #     redirect_to book_path(book), alert: "空白です。コメントを入力してください。"
  #   end
  # end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_back(fallback_location: root_path)
  end
end

 private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def ensure_correct_book_comment
    comment = BookComment.find(params[:id])
    unless comment.user == current_user
      redirect_to books_path
    end
  end