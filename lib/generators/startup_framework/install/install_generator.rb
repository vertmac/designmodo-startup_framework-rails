require 'rails/generators'
require 'pathname'

module StartupFramework
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Startup Framework files to designmodo-startup_framework-rails gem."
      argument :startup_dir, :type => :string, :banner => "<Licensed Startup Framework directory>"
      source_root File.expand_path("../templates", __FILE__)
      
      

      def copy_assets
        gem_assets_dir = File.expand_path("../../../../../app/assets", __FILE__)
        pro_dir = startup_dir
        
        common_files = "common-files"
				ui_kit = "ui-kit"

        if File.directory?(File.join(pro_dir, "Developer"))
          pro_dir = File.join(pro_dir, "Developer")
        end
        unless File.directory?(pro_dir) && File.directory?(File.join(pro_dir, ui_kit))
          raise "Invalid Startup Framework directory"
        end

        directory File.join(pro_dir, common_files,"less"),   File.join(gem_assets_dir, "less")
        directory File.join(pro_dir, common_files,"js"),     File.join(gem_assets_dir, "javascripts")
        directory File.join(pro_dir, common_files,"img"), 		File.join(gem_assets_dir, "images")
        directory File.join(pro_dir, common_files,"icons"),  File.join(gem_assets_dir, "images")
        directory File.join(pro_dir, common_files,"css"),  	File.join(gem_assets_dir, "stylesheets")
        directory File.join(pro_dir, common_files,"fonts"),  File.join(gem_assets_dir, "fonts")
        
        #Copy the ui-kit folder to the gems asset dir
        directory File.join(pro_dir, ui_kit),			File.join(gem_assets_dir, ui_kit)

      end

      def add_assets
        copy_file "startup_framework.js",   "app/assets/javascripts/startup_framework.js"
        copy_file "startup_framework.less", "app/assets/stylesheets/startup_framework.less"
      end

      def patch_assets
        gem_assets_dir = File.expand_path("../../../../../app/assets", __FILE__)
      end
      
    end
  end
end