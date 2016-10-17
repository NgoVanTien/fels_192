class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "record_isnt_exist"
      redirect_to root_url
    end
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:warning] = t "category_isnt_exist"
      redirect_to root_url
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "pl_login"
      redirect_to login_url
    end
  end

  def verify_user
    @user = User.find_by id: params[:id]
    unless current_user.is_user? @user
      redirect_to root_url
      flash[:warning] = t "record_isnt_exist"
    end
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
