#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

$:.unshift './lib', './'
require 'bundler'
Bundler.require
require 'sns-icon-redirector'

run SnsIconRedirector::Application
