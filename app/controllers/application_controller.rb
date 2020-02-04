class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery
  before_action :skip_session
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def skip_session
      request.session_options[:skip] = true
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :nickname, :name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :nickname, :name])
    end
end