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

  def login_logout_path
    content_tag :li do
      current_user && logout_path || login_path
    end
  end

  def logout_path
    link_to destroy_user_session_path, method: :delete, class: 'sesn-link' do
      html_span.html_safe + I18n.t("web.log_out")
    end
  end

  def login_path
    link_to new_user_session_path, class: 'sesn-link' do
      html_span.html_safe + I18n.t("web.log_in")
    end
  end

  def html_span
    content_tag( :span,class: "glyphicon glyphicon-log-in") do "" end + " "
  end

  def sign_up_path
    if current_user.nil?
      content_tag :li do
        link_to root_url do
          html_span + I18n.t("web.sign_up")
        end
      end
    end
  end

  def search_form_placeholder
    params["action"] == "dublin_bus" && "Enter stop name/id" || "Enter Station name/id"
  end

  def display_search_tab
    ["dublin_bus", "stop_info", "dublin_bikes", "station_info"].include?(params["action"])
  end

  def flash_class(level)
    case level
      when "notice" then "alert alert-info"
      when "success" then "alert alert-success"
      when "error" then "alert alert-error"
      when "alert" then "alert alert-error"
    end
  end

  def welcome_msg
    if current_user
      content_tag :li do
        link_to "javascript:void(0)" do
          html_span + I18n.t("web.welcome_msg") + " #{current_user.user_name || current_user.email} "
        end
      end      
    end
  end

  def display_image
    content_tag :li do
      image_tag(check_img, alt: "Default User", class: "img-circle default-user") if current_user
    end
  end

  def check_img
    current_user.image ||  "default_user.png" 
  end

  def delete_all_pokemons
    link_to I18n.t("web.delete_all"), pokemons_destroy_path, class: "btn btn-danger delete-btn" , method: 'delete', data: {confirm: I18n.t("web.confirmation_msg")}
  end
end
