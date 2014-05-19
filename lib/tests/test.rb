require File.join(File.dirname(__FILE__), 'test_helper')
 
require 'generators/cells/cell_generator'
 
class CellGeneratorTest < Rails::Generators::TestCase
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  setup :prepare_destination
  tests ::StartupFramework::Generators::InstallGenerator
 
  test "copy assets" do
    run_generator %w(/Users/roney/Workspace/artifacts/StartupFramework)
 
    assert_file "app/cells/blog_cell.rb", /class BlogCell < Cell::Rails/
    assert_file "app/cells/blog_cell.rb", /def post/
    assert_file "app/cells/blog_cell.rb", /def latest/
    assert_file "app/cells/blog/post.html.erb", %r(app/cells/blog/post.html.erb)
    assert_file "app/cells/blog/latest.html.erb", %r(app/cells/blog/latest.html.erb)
    assert_file "test/cells/blog_cell_test.rb"
  end  
end