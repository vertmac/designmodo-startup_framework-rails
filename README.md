<a href="http://designmodo.com/startup/?u=1124" rel="nofollow" title="Startup Framework" target="_blank"><img src="http://designmodo.com/img/affiliate/startupbright_728_90.jpg" border="0"  width="728" height="90" alt="Startup Framework" /></a>

This gem integrates Designmodo's Startup Framework into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per StartupFramework license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Startup Framework version.  Anything after these are gem versions.

[![Gem Version](https://badge.fury.io/rb/designmodo-startup_framework-rails.png)](http://badge.fury.io/rb/designmodo-startup_framework-rails)

## Installation
First install and configure dependencies:

[less-rails](https://github.com/metaskills/less-rails)

[jquery-ui-rails](https://github.com/joliss/jquery-ui-rails)

[twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)



Add this line to your application's Gemfile:

    gem 'designmodo-startup_framework-rails', '~> 1.1.3.10'

And then execute:

    $ bundle

### Install Generator
One **must** run this after install *and* after update of designmodo-startup_framework-rails gem:

    $ rails generate startup_framework:install <Startup Framework Directory>
    
In case you are already using [designmodo-flatuipro-rails](https://github.com/reflection/designmodo-flatuipro-rails) please use this option, 
    
    $ rails generate startup_framework:install <Startup Framework Directory> --flatuipro false

This will not copy over the bundled Flat UI files to the gem assuming that you are using [designmodo-flatuipro-rails](https://github.com/reflection/designmodo-flatuipro-rails).

###Generate Demo
Before running the demo generator, it is imperative that you run the install generator. Lets say you need to generate the sample-01 of Startup Framework. **Make sure that the sample directory exists.**

    $ rails generate startup_framework:demo 01
  
This will generate a route and corresponding controller/views etc called `'/startup_framework_demo/index01'`
All you need to do is just
  
    $ rails server

and navigate to http://localhost/startup_framework_demo/index01. You probably need to change teh image tags in case some images dont come up in the file `app/views/startup_framework_demo/index<xx>.html.erb` where `xx` stands for the sample number. 
  
The script is copied as `app/assets/javascripts/script<xx>.js` and the less file is copied as `app/assets/stylesheets<xx>.less`. You can use them as templates or modify them as your custom less files.

## Usage
After running the install generator, all assets should be setup. Here goes a template for the less file in case you are making your own view

    /*
     *
     *= require bootstrap_and_overrides.css
     *= require_self
    */
    
     @import 'startup_framework';
     
     /* header */
     @import '/startup-framework/ui-kit/ui-kit-header/less/header-10.less';
     
     /* content */
     @import '/startup-framework/ui-kit/ui-kit-content/less/content-3.less';
     @import '/startup-framework/ui-kit/ui-kit-content/less/content-20.less';
     
     
     /* footer */
     @import '/startup-framework/ui-kit/ui-kit-footer/less/footer-11.less';

## Thanks
If you haven't bought it already, please buy from designmodo.


## Thanks to
The idea generated from [StackOverFlow](http://stackoverflow.com/questions/23331056/designmodos-startup-framework-kit-with-ruby-on-rails/) where this particular question was raised in regards to startup-framework and rails integration.


##Queries
In case of queries please contact roney.baneree@vertmac.com


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request