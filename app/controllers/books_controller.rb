class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @new_book = Book.new
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = current_user
  end
  
  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    
    if @new_book.save
      redirect_to book_path(@new_book), notice: '本の投稿に成功しました successfully'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end
    
  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.user.id == current_user.id && @book.update(book_params)
      redirect_to book_path(@book), notice: '本を更新しました successfully'
    else
      @user = current_user
      flash.now[:alert] = '本の更新に失敗しました error'
      render :edit
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
