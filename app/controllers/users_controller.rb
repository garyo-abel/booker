class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id && @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'successfully'
    else
      render :edit
    end
  end
  
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @new_book = Book.new
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
