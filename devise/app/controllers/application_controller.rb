class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # layout :layout_by_controller

  # protected
  #
  # def layout_by_controller
  #   devise_controller? ? 'devise' : 'application'
  # end
   def after_sign_out_path_for(resource_or_scope)
     new_users_path
   end
end
