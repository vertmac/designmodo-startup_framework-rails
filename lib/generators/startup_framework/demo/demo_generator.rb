require 'rails/generators'
require 'pathname'

module StartupFramework
  module Generators
    class DemoGenerator < Rails::Generators::Base
      desc "Setup Startup Framework Demo page."
      source_root File.expand_path("../../../../../app/assets/demo", __FILE__)
			argument :sampleno, :type => :string, :banner => "<Sample Number like 01>"

      # Detect if Startup Framework Pro assets copied over to gem
      def check_startup_framework_install
        unless File.exist?(File.expand_path("../../../../../app/assets", __FILE__))
          raise "Please run install generator first"
        end
      end
			
			def check_sample_folder
				unless File.exist?(File.expand_path("../../../../../app/assets/demo/sample-#{sampleno}/index.html", __FILE__))
					raise "Please provide a correct sample number"
				end
			end
			

      def generate_demo_controller
        generate "controller startup_framework_demo index#{sampleno} --no-helper --no-test-framework --no-assets"
      end

      def add_demo_assets
        # Overwrite generated index.html.erb with demo html
        copy_file "sample-#{sampleno}/index.html.erb", "app/views/startup_framework_demo/index#{sampleno}.html.erb"

        # Add demo LESS
        copy_file "sample-#{sampleno}/less/style.less", "app/assets/stylesheets/sample#{sampleno}.less"
        
        # Handle CSS Manifest
        css_manifest = "app/assets/stylesheets/application.css"
        if File.exist?(css_manifest)
          content = File.read(css_manifest)
          unless content.match(/require_tree\s+\./)
            style_require_block = " *= require startup_framework_demo\n"
            insert_into_file css_manifest, style_require_block, :after => "require_self\n"
          end
        end
				
				#Add images
				directory File.join("sample-#{sampleno}","img"),   File.join("app", "assets", "images","img")
				

        # Add demo javascript
        copy_file "sample-#{sampleno}/js/script.js", "app/assets/javascripts/script#{sampleno}.js"

        # Handle JS Manifest
        js_manifest = "app/assets/javascripts/application.js"
        if File.exist?(js_manifest)
          content = File.read(js_manifest)
          unless content.match(/require_tree\s+\./)
            insert_into_file js_manifest, "//= require script#{sampleno}\n", :after => "startup_framework\n"
          end
        end
      end
    end
  end
end