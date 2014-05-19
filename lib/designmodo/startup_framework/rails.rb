require "designmodo/startup_framework/rails/version"

module Designmodo
  module StartupFramework
    module Rails
      class Engine < ::Rails::Engine
        initializer 'designmodo-startup_framework-rails.setup',
          :after => 'less-rails.after.load_config_initializers',
          :group => :all do |app|
            if defined?(Less)
              app.config.less.paths << File.join(config.root, 'app', 'less')
            end
          end
      end
    end
  end
end
