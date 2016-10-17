module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "user_log_in"
      redirect_to root_url
    end
  end

  def logged_in_as_admin
    unless current_user.is_admin?
      flash[:danger] = t "permission_limited"
      redirect_to root_url
    end
  end
end
