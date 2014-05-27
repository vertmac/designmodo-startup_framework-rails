<a href="http://designmodo.com/shop/?u=1124" rel="nofollow" title="Startup Framework" target="_blank"><img src="http://designmodo.com/img/affiliate/startupbright_728_90.jpg" border="0"  width="728" height="90" alt="Startup Framework" /></a>

This gem integrates Designmodo's Startup Framework into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per StartupFramwork license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Startup Framework version.  Anything after these are gem versions.

## Installation
First install and configure dependencies: 

[less-rails](https://github.com/metaskills/less-rails) 
[jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) 

These are optional and the whole thing works much better if you include these two as well in your gem file
[twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) 
[designmodo-flatuipro-rails](https://github.com/reflection/designmodo-flatuipro-rails) 


Add this line to your application's Gemfile:

    gem 'designmodo-startup_framework-rails', '~> 1.1.3.5'

And then execute:

    $ bundle


### Install Generator
One **must** run this after install *and* after update of designmodo-startup_framework-rails gem:

    $ rails generate startup_framework:install <Startup Framework Directory>

### Include in your less file
If you want to integrate the framework page:

    @startup-basePath: "/startup-framework/";

		@import 'flat-ui';
		@import 'startup_framework.less';

		/* header */
		@import '/startup-framework/ui-kit/ui-kit-header/less/header-10.less';

		/* content */
		@import '/startup-framework/ui-kit/ui-kit-content/less/content-3.less';
		@import '/startup-framework/ui-kit/ui-kit-content/less/content-20.less';


		/* footer */
		@import '/startup-framework/ui-kit/ui-kit-footer/less/footer-11.less';
		

You also need to include a manifest css files which looks like this

		/*
		 * This is a manifest file that'll be compiled into application.css, which will include all the files
		 * listed below.
		 *
		 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
		 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
		 *
		 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
		 * compiled file so the styles you add here take precedence over styles defined in any styles
		 * defined in the other CSS/SCSS files in this directory. It is generally better to create a new
		 * file per style scope.
		 *
		 *
		 *= require_self
		 *= require bootstrap_and_overrides.css
		 *= require signup_less
		*/



## Usage
After running the install generator, all assets should be setup.

## Thanks
If you haven't bought it already, please buy from designmodo.


## Thanks to
The idea generated from Forums where questions were raise in regards to startup-framework and rails integration.


##Queries
In case of queries please contact info@vertmac.com


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request