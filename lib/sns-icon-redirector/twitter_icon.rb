# -*- encoding: utf-8 -*-

require 'twitter'

module SnsIconRedirector
  class TwitterIcon < Icon
    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['consumer_key']
        config.consumer_secret     = ENV['consumer_secret']
        config.access_token        = ENV['access_token']
        config.access_token_secret = ENV['access_token_secret']
      end
    end

    def get(username) 
      begin
        @client.user(username).profile_image_url_https
      rescue => e
        p e
        nil
      end
    end
  end
end

