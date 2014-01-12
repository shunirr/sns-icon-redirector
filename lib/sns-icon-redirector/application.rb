# -*- encoding: utf-8 -*-

require 'http'

module SnsIconRedirector
  class Application < Sinatra::Base
    def initialize
      super
      @twitter_icon = TwitterIcon.new
      @facebook_icon = FacebookIcon.new
      @icons = {}
    end

    def get_icon(user)
      icon = {}
      icon[:expire_at] = Time.now + 24 * 60 * 60
      case user
      when /^[a-zA-Z0-9_]+$/
        icon[:url] = @twitter_icon.get params[:user]
      when /\(fb:(\d+)\)$/
        icon[:url] = @facebook_icon.get $1
      end
      if icon[:url]
        icon
      else
        nil
      end
    end

    get '/:user' do
      user = params[:user]
      icon = @icons[user] || get_icon(user)
      if icon
        if icon[:expire_at] < Time.now
          if HTTP.head(icon[:url]).status.to_s =~ /^40\d$/
            icon = get_icon user
          end
        end
        @icons[user] = icon
        redirect icon[:url]
      else
        status 404
        ''
      end
    end
  end
end

