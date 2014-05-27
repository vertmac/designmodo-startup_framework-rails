require 'rails/generators'
require 'pathname'

module StartupFramework
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Startup Framework files to designmodo-startup_framework-rails gem."
      argument :startup_dir, :type => :string, :banner => "<Licensed Startup Framework directory>"
      source_root File.expand_path("../templates", __FILE__)
      
      

      def copy_assets
        gem_assets_dir = File.expand_path("../../../../../", __FILE__)
        pro_dir = startup_dir
        
        @namespace = "startup-framework"
        @common_files = "common-files"
        @ui_kit = "ui-kit"
        
        @fonts_dir = "fonts/#{@namespace}/#{@common_files}/fonts"
        @images_dir = "images/#{@namespace}/#{@common_files}"
        @icons_dir = "#{@images_dir}/icons"
        @img_dir = "#{@images_dir}/img"
        @less_dir = "less/#{@namespace}/#{@common_files}/less"
        @css_dir = "stylesheets/#{@namespace}/#{@common_files}/css"
        @js_dir = "javascripts/#{@namespace}/#{@common_files}/js"
        @target_ui_kit = "less/#{@namespace}/#{@ui_kit}"
        
        FileUtils.mkdir_p File.join(gem_assets_dir,"app","assets",@fonts_dir)
        FileUtils.mkdir_p File.join(gem_assets_dir,"app","assets",@images_dir)
        FileUtils.mkdir_p File.join(gem_assets_dir,"app","assets",@js_dir)
        FileUtils.mkdir_p File.join(gem_assets_dir,"app","assets",@css_dir)
        FileUtils.mkdir_p File.join(gem_assets_dir,"app","assets",@less_dir)
        
        gem_assets_dir = File.join(gem_assets_dir,"app","assets")

        if File.directory?(File.join(pro_dir, "Developer"))
          pro_dir = File.join(pro_dir, "Developer")
        end
        unless File.directory?(pro_dir) && File.directory?(File.join(pro_dir, @ui_kit))
          raise "Invalid Startup Framework directory"
        end

				#Copy the fonts folder to the fonts dir
        directory File.join(pro_dir, @common_files,"fonts"),   File.join(gem_assets_dir, @fonts_dir)
        
				#Copy the icons folder to the images dir
        directory File.join(pro_dir, @common_files,"icons"),   File.join(gem_assets_dir, @icons_dir)
        directory File.join(pro_dir, @common_files,"img"),   File.join(gem_assets_dir, @img_dir)
        FileUtils.cp File.join(pro_dir, @common_files,"css/images/bx_loader.gif"),   File.join(gem_assets_dir, "images")
        FileUtils.cp File.join(pro_dir, @common_files,"css/images/controls.png"),   File.join(gem_assets_dir, "images")
        
				#Copy the js folder to the js dir
        directory File.join(pro_dir, @common_files,"js"),   File.join(gem_assets_dir, @js_dir)
        
				#Copy the less folder to the less dir
        directory File.join(pro_dir, @common_files,"less"),   File.join(gem_assets_dir, @less_dir)
        
        #Copy the ui-kit folder to the gems asset dir
        directory File.join(pro_dir, @ui_kit),			File.join(gem_assets_dir, @target_ui_kit)
        
        #Remove all non LESS files from ui-kit folder
        
        Dir.glob("#{gem_assets_dir}/#{@target_ui_kit}/**/*.*") do |file|
          unless file =~ /\.less\Z/
            puts "Deleting file #{File.basename file}"
            FileUtils.rm file, force: true
          end
        end
        

      end

      def add_assets
        copy_file "startup_framework.js",   "app/assets/javascripts/startup_framework.js"
        copy_file "startup_framework.less", "app/assets/stylesheets/startup_framework.less"
      end

      def patch_assets
        gem_assets_dir = File.expand_path("../../../../../app/assets/", __FILE__)

        #Replace fonts-path
        gsub_file File.join(gem_assets_dir, @less_dir, "helper.less"), /\.\.\/fonts\//, "@{startup-basePath}common-files/fonts/"

        
        # replace all urls with asset urls with the exception of data urls
        Dir.glob("#{gem_assets_dir}/#{@less_dir}/*.less") do |less_file|
          
          if less_file =~ /icon-font\.less\Z/
            gsub_file less_file, /url\((.+?)\)/, 'font-url(\\1)'
          else
            gsub_file less_file, /url\((.+?)\)/, 'image-url(\\1)'
          end
        end
        
        Dir.glob("#{gem_assets_dir}/#{@target_ui_kit}/**/*.less") do |ui_kit_less_file|
          #replace all files with the exception of price-common.less
          unless ui_kit_less_file =~ /price-common\.less\Z/
            gsub_file ui_kit_less_file, /url\((.+?)\)/, 'image-url(\\1)'
          end
        end
        

        # icon-font.less Do it for all less files in common-files/less and ui-kit folder
        #gsub_file File.join(gem_assets_dir, @less_dir, "icon-font.less"), /url\((.+?)\)/, 'asset-url(\\1)'
        
      end
      
    end
  end
end