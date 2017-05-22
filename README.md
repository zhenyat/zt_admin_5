# ZtAdmin

Gem to generate Admin files for RoR App via CLI. It's further development of *bkc_admin* gem.

## Functionality:



## Versions:

Ruby 2.4.1, Rails 5.0.3     (v.1.3.0)

## Development

$ chruby 2.4.1

$ bundle gem zt_admin

Then update files:

  lib/zt_admin.rb, bin/zt_admin, zt_admin.gemspec, .gitignore

## Run:

$ rm zt_admin-0.1.0.gem; git add .; gem build zt_admin.gemspec; sudo gem install --local zt_admin-0.1.0.gem

$ bin/zt_admin

# Admin Development:

$ rails g controller sessions new

. . .

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Issues to be solved

