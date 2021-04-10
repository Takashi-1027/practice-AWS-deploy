class BooksController < ApplicationController
  # [29. ログイン中にURLを入力すると他人が投稿した本の編集ページに遷移できないようにする]
  # 他人が投稿した本の編集ページに遷移できないようにするには 本の投稿者とログインユーザを比較する処理
  # 他人が編集(:edit)して、投稿(:update)できないようにする。
  before_action :authenticate_user! # 答え-エラーが出たら消す ログインしているユーザーしか投稿関連を行えないようにする
  before_action :ensure_correct_book, only: [:update, :edit, :destroy]


  def show
    @book = Book.find(params[:id])
    @book_new = Book.new # <==[22. 本の詳細ページで新規投稿フォームが編集フォームになっている] 何も情報が入っていない空のモデルを渡すために追加した。Book.newを記述すると空のモデルが生成され、インスタンス変数@empty_bookに代入されてViewで利用できるようになります。
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @switch_on_favorite = true
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      flash[:alert] = '未入力です。メッセージを入力してください。'
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    # [18. 本の投稿ができない: エラーメッセージが表示されない]を以下の通りに修正した
    # params.require(:book).permit(:title)
    # params.require(:book).permit(:title, :body) <== :bodyを追加した
    params.require(:book).permit(:title, :body)
  end


  # [29. ログイン中にURLを入力すると他人が投稿した本の編集ページに遷移できないようにする]
  # 他人が投稿した本の編集ページに遷移できないようにするには 本の投稿者とログインユーザを比較する処理
  def ensure_correct_book
    @book = Book.find(params[:id])
    unless @book.user == current_user
     redirect_to books_path
    end
  end


end
