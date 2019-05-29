class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    return @user if @user = User.find_by(id: params[:id])
    flash.now[:danger] = t "errors.user_not_found"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = t "statics_page.home.sample_app"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_cormfirmation
  end
end
