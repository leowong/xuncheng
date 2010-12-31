class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cache_buster, :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_locale
    I18n.locale = I18n.default_locale
    if current_user and current_user.locale
      if I18n.available_locales.include?(current_user.locale.to_sym)
        I18n.locale = current_user.locale
      end
    end
  end
end
