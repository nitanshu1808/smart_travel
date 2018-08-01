class ApplicationController < ActionController::Base

	protected
  def after_sign_in_path_for(resource)
    dublin_bus_url
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end
end
