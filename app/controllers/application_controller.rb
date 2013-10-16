class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  rescue_from BetVictor::RecordNotFound do |exception|
    render :file => "#{Rails.root}/public/404", :formats => [:html], :layout => false, :status => 404
  end

  protected

  def set_locale
    I18n.locale = I18n.default_locale

    locale = params["locale"].to_sym rescue nil

    if I18n.available_locales.include?(locale)
      session["locale"] = locale
    end

    if session["locale"].present?
      I18n.locale = session["locale"]
    end
  end

  def api_client
    # we need to instantiate a new ApiClient for every request

    BetVictor::ApiClient.new
  end
end
