class ApplicationController < ActionController::Base
  before_action do
    ServerTiming::Auth.ok!
  end

  before_action :set_locale
  before_action :set_ts
  before_action :prepare_seo_variable
  before_action :set_ie_warning

  private

    def set_locale
      if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
        cookies['locale'] = { :value => params[:locale], :expires => 1.year.from_now }
        I18n.locale = params[:locale].to_sym
      elsif cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
        I18n.locale = cookies['locale'].to_sym
      elsif ! extract_locale_from_accept_language_header.blank? && I18n.available_locales.include?(extract_locale_from_accept_language_header.to_sym)
        I18n.locale = extract_locale_from_accept_language_header
        cookies['locale'] = { :value => params[:locale], :expires => 1.year.from_now }
      else
        I18n.locale = :cn
      end
    end

    def extract_locale_from_accept_language_header
      begin
        @http_locale ||= request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      rescue Exception => e
        'cn'
      end
    end

    def set_ts
      if params[:ts].present?
        cookies['ts'] = { :value => params[:ts], :expires => 1.year.from_now }
      end
    end

    def prepare_seo_variable
      @seo = Seo.first
    end

    def set_ie_warning
      if browser.ie?
        flash.now[:alert] = "本站点推荐在Chrome, Edge, Firefox等非IE浏览器下浏览，Chrome浏览器可以在<a href='https://www.google.cn/intl/zh-CN/chrome/'>https://www.google.cn/intl/zh-CN/chrome/</a>下载。".html_safe
      end
    end
end
