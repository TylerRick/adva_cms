require File.expand_path('../../../test_helper', __FILE__)

require 'rack'
require 'adva/routing_filters/section_root'
require 'adva/routing_filters/section_path'

module AdvaStatic
  class RackWatchTest < Test::Unit::TestCase
    include Adva::Static::Rack

    class PagesController < ActionController::Base; end
    
    attr_reader :app, :export_dir, :import_dir
    
    def setup
      # TODO fix devise to be able to load up w/o a Rails.application being present
      Rails.application = Rails::Application.send(:new)
      Rails.application.singleton_class.send(:include, Rails::Application::Configurable)
      Devise.warden_config = Rails.application.config

      @export_dir = dir('/tmp/adva-static-test/export')
      @import_dir = dir('/tmp/adva-static-test/import')

      Site.create!(:host => 'rails-i18n.org', :name => 'name', :title => 'title', :sections_attributes => [
        { :type => 'Page', :title => 'Home' }
      ])
      super
    end

    def teardown
      Rails.application = nil
      
      watch.send(:kill_watcher)
      FileUtils.rm_r(import_dir)
      FileUtils.rm_r(export_dir)
      @watch = nil
      
      super
    end
    
    test "requests files referenced by a given rack-cache.purge header" do
      @app = lambda do |env| 
        case env['PATH_INFO']
        when '/'
          [200, { PURGE_HEADER => ['/bar', '/baz'] }, '200 ok']
        else
          [200, {}, env['PATH_INFO']]
        end
      end
      
      watch.call(env_for('/'))
    
      assert export_dir.join('index.html').file?
      assert export_dir.join('bar.html').file?
      assert export_dir.join('baz.html').file?
    end
    
    test "foo" do
      @app = lambda { |env| [200, {}, env['PATH_INFO']] }
      
      file = import_dir.join('home.yml')
      FileUtils.touch(file)
      assert !export_dir.join('index.html').file?
      
      watch
      File.utime(file.mtime, future, file)
      sleep(1)
      
      # assert export_dir.join('index.html').file?
    end
    
    protected

      def routes
        @routes ||= ActionDispatch::Routing::RouteSet.new.tap do |routes|
          routes.draw do
            filter :section_root, :section_path
            match '/pages/:id', :to => "#{PagesController.new.controller_path}#show"
          end
        end
      end

      def watch
        @watch ||= Watch.new(Export.new(@app, :target => export_dir), :dir => import_dir, :routes => routes)
      end

      def dir(path)
        Pathname.new(path).tap { |path| FileUtils.mkdir_p(path) }
      end

      def future
        Time.local(Time.now.year + 1, Time.now.month, Time.now.day)
      end

      def env_for(uri, options = nil)
        Rack::MockRequest.env_for(uri, options || {})
      end
  end
end