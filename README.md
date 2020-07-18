# ZtAdmin

Gem to generate Admin files for RoR App via CLI. It's further development of *bkc_admin* gem.

## Functionality:

## Versions:

Ruby 2.4.2, Rails 5.1.4     (v.1.10.0 - 1.13.0)
     2.5.8,       5.2.4.3   (v.1.14.0)

## Development

$ chruby 2.5.8

$ bundle gem zt_admin

Then update files:

  lib/zt_admin.rb, bin/zt_admin, zt_admin.gemspec, .gitignore

## Run:

$ rm zt_admin*.gem; git add .; gem build zt_admin.gemspec; sudo gem install --local zt_admin-1.14.0.gem

$ bin/zt_admin

## Uninstall gem

$ gem uninstall -i /Users/zhenya/.rubies/ruby-2.5.0/lib/ruby/gems/2.5.0 zt_admin

# Admin Development:

$ rails g controller sessions new

. . .

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Issues to be solved

