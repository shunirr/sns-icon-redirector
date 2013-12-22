# -*- encoding: utf-8 -*-

require 'pit'
require 'twitter'

module SnsIconRedirector
  class TwitterIcon < Icon
    def initialize
      pit = Pit.get("twitter", :require => {
        'consumer_key'        => "YOUR_CONSUMER_KEY",
        'consumer_secret'     => "YOUR_CONSUMER_SECRET",
        'access_token'        => "YOUR_ACCESS_TOKEN",
        'access_token_secret' => "YOUR_ACCESS_SECRET"
      })
      
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key       = pit['consumer_key']
        config.consumer_secret    = pit['consumer_secret']
        config.oauth_token        = pit['access_token']
        config.oauth_token_secret = pit['access_token_secret']
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

