<a href="http://designmodo.com/startup/?u=1124" rel="nofollow" title="Startup Framework" target="_blank"><img src="http://designmodo.com/img/affiliate/startupbright_728_90.jpg" border="0"  width="728" height="90" alt="Startup Framework" /></a>

This gem integrates Designmodo's Startup Framework into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per StartupFramework license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Startup Framework version.  Anything after these are gem versions.

[![Gem Version](https://badge.fury.io/rb/designmodo-startup_framework-rails.png)](http://badge.fury.io/rb/designmodo-startup_framework-rails)

## Installation
First install and configure dependencies: 

[less-rails](https://github.com/metaskills/less-rails) 
[jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) 

These are optional and the whole thing works much better if you include these two as well in your gem file
[twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) 
[designmodo-flatuipro-rails](https://github.com/reflection/designmodo-flatuipro-rails) 


Add this line to your application's Gemfile:

    gem 'designmodo-startup_framework-rails', '~> 1.1.3.9'

And then execute:

    $ bundle


### Install Generator
One **must** run this after install *and* after update of designmodo-startup_framework-rails gem:

    $ rails generate startup_framework:install <Startup Framework Directory>

### Include in your less file
**Dont use the variable @startup-basePath. This is used internally everywhere and shouldn't be overriden**
If you want to create a less by the name signup.less which pretty much looks like this:

		 /*
		  *
		  *= require bootstrap_and_overrides.css
		  *= require_self
		 */
		 
		@import 'flatuipro';
		@import 'startup_framework';

		/* header */
		@import '/startup-framework/ui-kit/ui-kit-header/less/header-10.less';

		/* content */
		@import '/startup-framework/ui-kit/ui-kit-content/less/content-3.less';
		@import '/startup-framework/ui-kit/ui-kit-content/less/content-20.less';


		/* footer */
		@import '/startup-framework/ui-kit/ui-kit-footer/less/footer-11.less';

The whole file for e.g. signup.less can be referred anywhere else in your views or in the application.css
In case you use capistrano and use local asset precompile logic, in that case you wouldn't require to checkin your Startup-Framework into CVS/Git or you also dont need to copy them to your production server.

## Usage
After running the install generator, all assets should be setup.

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