# encoding: utf-8

$: << File.expand_path('../lib', __FILE__)
require 'adva/version'

Gem::Specification.new do |s|
  s.name         = "adva-user"
  s.version      = Adva::VERSION
  s.authors      = ["Ingo Weiss", "Sven Fuchs"]
  s.email        = "nobody@adva-cms.org"
  s.homepage     = "http://github.com/svenfuchs/adva-cms2"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files        = Dir['{app,config,lib,public}/**/*']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  
  s.add_dependency 'adva-core'
  s.add_dependency 'devise', '1.1.rc1'
end