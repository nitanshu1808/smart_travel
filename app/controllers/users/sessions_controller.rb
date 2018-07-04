# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.valid_password?(params[:user][:password])
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      redirect_to dublin_bus_url
    else
      @user = @user || User.new(signin_params)
      @user.errors.add(:password, I18n.t('web.invalid_credentials'))
      render 'new'
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  private
  def signin_params
    params.require(:user).permit(:email, :password)
  end

end
