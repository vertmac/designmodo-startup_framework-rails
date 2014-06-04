require File.join(File.dirname(__FILE__), 'test_helper')
require 'generators/startup_framework/install/install_generator'
 
class InstallGeneratorTest < Rails::Generators::TestCase
  destination File.expand_path("dummy", File.dirname(__FILE__))
  setup :prepare_destination
  tests ::StartupFramework::Generators::InstallGenerator
 
  test "copy assets" do
		puts 'Halo World'
    run_generator %w(/Users/roney/Workspace/artifacts/StartupFramework)
 
    assert_file "app/cells/blog_cell.rb", /class BlogCell < Cell::Rails/
    assert_file "app/cells/blog_cell.rb", /def post/
    assert_file "app/cells/blog_cell.rb", /def latest/
    assert_file "app/cells/blog/post.html.erb", %r(app/cells/blog/post.html.erb)
    assert_file "app/cells/blog/latest.html.erb", %r(app/cells/blog/latest.html.erb)
    assert_file "test/cells/blog_cell_test.rb"
  end  
end

# Configure Rails Environment
# ENV["RAILS_ENV"] = "test"
# 
# require File.expand_path("../dummy/config/environment.rb",  __FILE__)
# require "rails/test_help"
# 
# Rails.backtrace_cleaner.remove_silencers!
# 
# # Load support files
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
# 
# # Load fixtures from the engine
# if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#   ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
# end
