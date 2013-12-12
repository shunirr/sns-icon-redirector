# -*- encoding: utf-8 -*-

require 'sinatra'

module SnsIconRedirector
  autoload :Application,  'sns-icon-redirector/application'
  autoload :FacebookIcon, 'sns-icon-redirector/facebook_icon'
  autoload :TwitterIcon,  'sns-icon-redirector/twitter_icon'
end
