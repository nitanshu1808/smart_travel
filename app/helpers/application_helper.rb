module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @user ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def check_redirect_url
    current_user.present? && 'javascript:void(0)' || root_url   
  end

end
