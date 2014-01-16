# -*- encoding: utf-8 -*-

require 'http'
require 'tmp_cache'

module SnsIconRedirector
  class Application < Sinatra::Base
    def initialize
      super
      @twitter_icon = TwitterIcon.new
      @facebook_icon = FacebookIcon.new
      @icons = {}
    end

    def get_icon(user)
      icon = nil
      case user
      when /^[a-zA-Z0-9_]+$/
        icon = @twitter_icon.get user
      when /\(fb:(\d+)\)$/
        icon = @facebook_icon.get $1
      end
      icon
    end

    get '/:user' do
      user = params[:user]
      icon = TmpCache.get user
      unless icon
        icon = get_icon user
        TmpCache.set user, icon, 60 * 60 * (rand(12) + 1)
      end
      if icon
        redirect icon
      else
        status 404
        ''
      end
    end
  end
end

