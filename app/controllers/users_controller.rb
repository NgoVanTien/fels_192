class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :verify_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.order_name.paginate page: params[:page],
      per_page: Settings.per_page.users
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete_user"
    else
      flash[:warning] = t "delete_user_fail"
    end
    redirect_to :back
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
