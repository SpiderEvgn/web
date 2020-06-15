class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_ie_warning

  private

    def set_locale
      I18n.locale = params[:locale].presence || I18n.default_locale
    end

    def set_ie_warning
      if browser.ie?
        flash.now[:alert] = "本站点推荐在Chrome, Edge, Firefox等非IE浏览器下浏览，Chrome浏览器可以在<a href='https://www.google.cn/intl/zh-CN/chrome/'>https://www.google.cn/intl/zh-CN/chrome/</a>下载。".html_safe
      end
    end
end
