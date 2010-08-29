require File.expand_path('../../test_helper', __FILE__)

module Tests
  module Core
    module Importers
      module Directory
        class PageTest < Test::Unit::TestCase
          include Setup, Adva::Importers::Directory::Models

          test "Page.build finds a root page" do
            setup_root_page
            assert_equal 1, Section.build(root.paths).size
          end
    
          test "Page.build finds a non_root page" do
            setup_non_root_page
            assert_equal 1, Section.build(root.paths).size
          end
        end
      end
    end
  end
end