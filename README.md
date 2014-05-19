

This gem integrates Designmodo's Startup Framework into the Rails 3 and 4 Asset Pipeline.

You **must** purchase and download a licensed copy to use this gem (none of the assets are packaged per Flat UI Pro license).  You may do so by clicking the above image (full disclosure: affiliate link).

The version major and minors should match the Startup Framework version.  Anything after these are gem versions.

## Installation
First install and configure dependencies: [less-rails-bootstrap](https://github.com/metaskills/less-rails-bootstrap) and [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails) If you need Flat UI Pro components, please install [designmodo-flatuipro-rails].

Add this line to your application's Gemfile:

    gem 'designmodo-startup_framework-rails', '~> 1.1.3'

And then execute:

    $ bundle


### Install Generator
One **must** run this after install *and* after update of designmodo-startup_framework-rails gem:

    $ rails generate startup_framework:install <Startup Framework Directory>

### Include in your less file
If you want to integrate the framework page:

    @include 'startup_framework.less'



## Usage
After running the install generator, all assets should be setup.

## Thanks
If you haven't bought it already, please buy from designmodo.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request