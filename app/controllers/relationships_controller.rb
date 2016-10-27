class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    verify_user_relationship
    current_user.follow @user
    responds
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    verify_user_relationship
    current_user.unfollow @user
    responds
  end
  private
    def verify_user_relationship
      unless @user
        flash[:warning] = t "record_isnt_exist"
        redirect_to root_url
      end
    end

    def responds
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    end
end
