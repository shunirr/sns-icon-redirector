# -*- encoding: utf-8 -*-

module SnsIconRedirector
  class Application < Sinatra::Base
    def initialize
      super
      @twitter_icon = TwitterIcon.new
      @facebook_icon = FacebookIcon.new
      @icons = {}
    end

    get '/:user' do
      user = params[:user]
      url = @icons[user]
      if url.nil? then
        case user
        when /^[a-zA-Z0-9_]+$/
          url = @twitter_icon.get params[:user]
        when /\((\d+)\)$/
          url = @twitter_icon.get $1
        end
        @icons[params[:user]] = url if url
      end
    
      if url.nil? then
        status 404
        ''
      else
        redirect url
      end
    end
  end
end

