class ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = extract_locale_from_accept_language_header
    locale = I18n.default_locale unless locale.in?(I18n.available_locales.map(&:to_s))
    I18n.with_locale(locale, &action)
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE'].present?
  end
end
