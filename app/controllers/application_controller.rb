class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # [10. ログイン後にtopページが表示されてしまう] root_pathをuser_pathへ修正した。
  # current_userは現在ログインしているユーザーの情報を簡単にとってくることができるメソッド。

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
