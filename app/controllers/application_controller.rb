class ApplicationController < ActionController::Base
	protected
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || root_url
    end
end
