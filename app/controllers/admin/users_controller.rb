class Admin::UsersController < ApplicationController
  def index
    @users = User.order_name.paginate page: params[:page],
      per_page: Settings.per_page.users
  end
end
