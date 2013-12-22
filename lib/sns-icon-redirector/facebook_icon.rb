# -*- encoding: utf-8 -*-

require 'json'
require 'open-uri'

module SnsIconRedirector
  class FacebookIcon < Icon
    def get(user_id)
      begin
        facebook_user = JSON.parse(open("https://graph.facebook.com/#{user_id}?fields=picture").read)
        facebook_user['picture']['data']['url']
      rescue => e
        p e
        nil
      end
    end
  end
end

