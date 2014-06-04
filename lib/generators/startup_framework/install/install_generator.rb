require 'rails/generators'
require 'pathname'

module StartupFramework
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Startup Framework files to designmodo-startup_framework-rails gem."
      argument :startup_dir, :type => :string, :banner => "<Licensed Startup Framework directory>"
			class_option :flatui, :type => :boolean, :default => true, :description => 'Include bundled Flat UI'
			class_option :demo, :type => :boolean, :default => false,  :description => 'Include bundled samples'
      source_root File.expand_path("../templates", __FILE__)
      

      def copy_assets
        @gem_assets_dir = File.expand_path("../../../../../", __FILE__)
        @pro_dir = startup_dir
        
        @namespace = "startup-framework"
        @common_files = "common-files"
        @ui_kit = "ui-kit"
				@flat_ui = "flat-ui"
        
        @fonts_dir = "fonts/#{@namespace}/#{@common_files}/fonts"
        @images_dir = "images/#{@namespace}/#{@common_files}"
        @icons_dir = "#{@images_dir}/icons"
        @img_dir = "#{@images_dir}/img"
        @less_dir = "less/#{@namespace}/#{@common_files}/less"
        @css_dir = "stylesheets/#{@namespace}/#{@common_files}/css"
        @js_dir = "javascripts/#{@namespace}/#{@common_files}/js"
        @target_ui_kit = "less/#{@namespace}/#{@ui_kit}"
        
        FileUtils.mkdir_p File.join(@gem_assets_dir,"app","assets",@fonts_dir)
        FileUtils.mkdir_p File.join(@gem_assets_dir,"app","assets",@images_dir)
        FileUtils.mkdir_p File.join(@gem_assets_dir,"app","assets",@js_dir)
        FileUtils.mkdir_p File.join(@gem_assets_dir,"app","assets",@css_dir)
        FileUtils.mkdir_p File.join(@gem_assets_dir,"app","assets",@less_dir)
        
        @gem_assets_dir = File.join(@gem_assets_dir,"app","assets")

        if File.directory?(File.join(@pro_dir, "Developer"))
          @pro_dir = File.join(@pro_dir, "Developer")
        end
        unless File.directory?(@pro_dir) && File.directory?(File.join(@pro_dir, @ui_kit))
          raise "Invalid Startup Framework directory"
        end

				#Copy the fonts folder to the fonts dir
        directory File.join(@pro_dir, @common_files,"fonts"),   File.join(@gem_assets_dir, @fonts_dir)
        
				#Copy the icons folder to the images dir
        directory File.join(@pro_dir, @common_files,"icons"),   File.join(@gem_assets_dir, @icons_dir)
        directory File.join(@pro_dir, @common_files,"img"),   File.join(@gem_assets_dir, @img_dir)
        FileUtils.cp File.join(@pro_dir, @common_files,"css/images/bx_loader.gif"),   File.join(@gem_assets_dir, "images")
        FileUtils.cp File.join(@pro_dir, @common_files,"css/images/controls.png"),   File.join(@gem_assets_dir, "images")
        
				#Copy the js folder to the js dir
        directory File.join(@pro_dir, @common_files,"js"),   File.join(@gem_assets_dir, @js_dir)
        
				#Copy the less folder to the less dir
        directory File.join(@pro_dir, @common_files,"less"),   File.join(@gem_assets_dir, @less_dir)
        
        #Copy the ui-kit folder to the gems asset dir
        directory File.join(@pro_dir, @ui_kit),     File.join(@gem_assets_dir, @target_ui_kit)
				
				#Copy demo assets
				directory File.join(@pro_dir,"samples"), File.join(@gem_assets_dir, "demo")
				
				#Copy the flat ui directory
				if options[:flatui]
					copy_flatui
				end
        
        #Remove all non LESS files from ui-kit folder
        
        Dir.glob("#{@gem_assets_dir}/#{@target_ui_kit}/**/*.*") do |file|
          unless file =~ /\.less\Z/
            puts "Deleting file #{File.basename file}"
            FileUtils.rm file, force: true
          end
        end
				
				if options[:demo]
					copy_demo
				end
        

      end

      def add_assets
        copy_file "startup_framework.js",   "app/assets/javascripts/startup_framework.js"
        copy_file "startup_framework.less", "app/assets/stylesheets/startup_framework.less"
				if options[:flatui]
					copy_file "flatui.js", "app/assets/javascripts/flatui.js"
				end
				
				# Handle JS Manifest
	      js_manifest = "app/assets/javascripts/application.js"
	      if File.exist?(js_manifest)
	        content = File.read(js_manifest)
	        unless content.match(/require\s+startup_framework/)
	          insert_into_file js_manifest, "//= require startup_framework\n", :after => "twitter/bootstrap\n"
						if options[:flatui]
							insert_into_file js_manifest, "//= require flatui\n", :after => "twitter/bootstrap\n"
						end
	        end
	        unless content.match(/require\s+jquery.ui.all/)
	          unless content.match(/require\s+jquery.ui.effect/)
	            insert_into_file js_manifest, "//= require jquery.ui.effect\n", :after => "jquery\n"
	          end
	          unless content.match(/require\s+jquery.ui.tooltip/)
	            insert_into_file js_manifest, "//= require jquery.ui.tooltip\n", :after => "jquery\n"
	          end
	          unless content.match(/require\s+jquery.ui.spinner/)
	            insert_into_file js_manifest, "//= require jquery.ui.spinner\n", :after => "jquery\n"
	          end
	          unless content.match(/require\s+jquery.ui.slider/)
	            insert_into_file js_manifest, "//= require jquery.ui.slider\n", :after => "jquery\n"
	          end
	          unless content.match(/require\s+jquery.ui.datepicker/)
	            insert_into_file js_manifest, "//= require jquery.ui.datepicker\n", :after => "jquery\n"
	          end
	          unless content.match(/require\s+jquery.ui.button/)
	            insert_into_file js_manifest, "//= require jquery.ui.button\n", :after => "jquery\n"
	          end
	        end
	      else
	        copy_file "application.js", js_manifest
	      end

	      # Handle CSS Manifest
	      css_manifest = "app/assets/stylesheets/application.css"
	      if File.exist?(css_manifest)
	        content = File.read(css_manifest)
	        unless content.match(/require_tree\s+\./)
	          style_require_block = " *= require startup_framework\n"
	          insert_into_file css_manifest, style_require_block, :after => "require_self\n"
	        end
	      else
	        copy_file "application.css", "app/assets/stylesheets/application.css"
	      end
				
      end

      def patch_assets
        @gem_assets_dir = File.expand_path("../../../../../app/assets/", __FILE__)

        #Replace fonts-path
        gsub_file File.join(@gem_assets_dir, @less_dir, "helper.less"), /\.\.\/fonts\//, "@{startup-basePath}common-files/fonts/"

        
        # replace all urls with asset urls with the exception of data urls
        Dir.glob("#{@gem_assets_dir}/#{@less_dir}/*.less") do |less_file|
          
          if less_file =~ /icon-font\.less\Z/
            gsub_file less_file, /url\((.+?)\)/, 'font-url(\\1)'
          else
            gsub_file less_file, /url\((.+?)\)/, 'image-url(\\1)'
          end
        end
        
        Dir.glob("#{@gem_assets_dir}/#{@target_ui_kit}/**/*.less") do |ui_kit_less_file|
          #replace all files with the exception of price-common.less
          unless ui_kit_less_file =~ /price-common\.less\Z/
            gsub_file ui_kit_less_file, /url\((.+?)\)/, 'image-url(\\1)'
          end
        end
				
				
			 Dir.glob("#{@gem_assets_dir}/demo/**/*.html") do |html_file|
				 # gsub_file html_file, /<img src="img\/.+?>/ do |s|
#              match = /img\/(.+?)"/.match(s)
#              '<%= image_tag "' + match[1] + '" %>'
#           end
         
         gsub_file html_file, /src=\"img\//, "src=\"/assets/img/"
         gsub_file html_file, %r(src="../../), "src=\"/assets/startup-framework/"
				 
				 # Remove everything before <body> tag and after 'Load JS', inclusive
         new_file = File.open("#{html_file}.erb", "w")
				 puts "Creating ERB files"
         include_line = false
         IO.foreach(html_file) do |line|
           include_line = false if line =~ /Placed at the end/

           new_file.write line if include_line

           include_line = true if line =~ /<body>/
         end
         new_file.close
				 
			 end
			 
			 Dir.glob("#{@gem_assets_dir}/demo/**/*.less") do |less_file|
				gsub_file less_file, %r(../../../), "/startup-framework/"
        
        insert_into_file less_file, "@import 'startup_framework';\n", :before => "/* header"
        
        f = File.new(less_file, 'r+')
        f.each_line do |line|
          if line.include? 'common-files' or line.include? 'flat-ui'
            # seek back to the beginning of the line.
            f.seek(-line.length, IO::SEEK_CUR)

            # overwrite line with spaces and add a newline char
            f.write(' ' * (line.length - 1))
            f.write("\n")
          end
        end
        f.close
      
			 end
        
				
				if options[:flatui]
					# switch.less
	        # More involved patch because less-rails won't translate when inside ~""
	        # Create LESS variable and interpolate into .mask(~"")
	        switch_file = File.join(@gem_assets_dir, "less/modules", "switch.less")
	        mask_image_url = "@mask-image-url: image-url('switch/mask.png');\n"
	        insert_into_file switch_file, mask_image_url, :before => ".has-switch {\n"
	        gsub_file switch_file, /url\('\.\.\/images\/.+?\)/, "@{mask-image-url}"
				end
        # icon-font.less Do it for all less files in common-files/less and ui-kit folder
        #gsub_file File.join(@gem_assets_dir, @less_dir, "icon-font.less"), /url\((.+?)\)/, 'asset-url(\\1)'
      end
			
			
			private
			
			def copy_flatui
				puts "Copying flat ui files"
				directory File.join(@pro_dir, @flat_ui,"fonts"),   File.join(@gem_assets_dir, "fonts")
				directory File.join(@pro_dir, @flat_ui,"images"),   File.join(@gem_assets_dir, "images")
				directory File.join(@pro_dir, @flat_ui,"js"),   File.join(@gem_assets_dir, "javascripts")
				directory File.join(@pro_dir, @flat_ui,"less"),   File.join(@gem_assets_dir, "less")
			end
			
			def generate_demo
				
			end
      
    end
  end
end