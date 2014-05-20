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
        
        
        FileUtils.mkdir_p File.join(gem_assets_dir,"vendor","assets","frameworks","startup-framework")
        gem_assets_dir = File.join(gem_assets_dir,"vendor","assets","frameworks","startup-framework")
        
        common_files = "common-files"
				ui_kit = "ui-kit"

        if File.directory?(File.join(pro_dir, "Developer"))
          pro_dir = File.join(pro_dir, "Developer")
        end
        unless File.directory?(pro_dir) && File.directory?(File.join(pro_dir, ui_kit))
          raise "Invalid Startup Framework directory"
        end

				#Copy the common-files folder to the gems asset dir
        directory File.join(pro_dir, common_files),   File.join(gem_assets_dir, common_files)
        
        #Copy the ui-kit folder to the gems asset dir
        directory File.join(pro_dir, ui_kit),			File.join(gem_assets_dir, ui_kit)

      end

      def add_assets
        copy_file "startup_framework.js",   "app/assets/javascripts/startup_framework.js"
        copy_file "startup_framework.less", "app/assets/stylesheets/startup_framework.less"
      end

      def patch_assets
        gem_assets_dir = File.expand_path("../../../../../vendor/assets/frameworks/startup-framework", __FILE__)

       
        gsub_file File.join(gem_assets_dir, "common-files/less", "icon-font.less"), /\@\{startup\-fontPath\}/, '/assets/startup-framework/common-files/fonts/'
        gsub_file File.join(gem_assets_dir, "common-files/less", "helper.less"), /url\("\.\.\/fonts\//, '/assets/startup-framework/common-files/fonts/'

        
      end
      
    end
  end
end