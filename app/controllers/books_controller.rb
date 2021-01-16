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
      redirect_to user_path(current_user.id), notice: '本の投稿に成功しました'
    else
      @user = current_user
      flash.now[:alert] = '本の投稿に失敗しました'
      render('user/show')
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to user_path(current_user)
  end
    
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to user_path(current_user), notice: '本を更新しました'
    else
      @user = current_user
      flash.now[:alert] = '本の更新に失敗しました'
      render('user/show')
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
