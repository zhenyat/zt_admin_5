# ZtAdmin v.2.3.0

Gem to generate Admin files for RoR App via CLI. It's further development of *bkc_admin* gem.

## Functionality
```
v1: Standard RoR Admin Generator & FE
v2: webpacker with ReactJS to be applied for FE
```
Gemfile for Raspbian has been added

## Versions
```
v1: Ruby 2.4.2, Rails 5.1.4  (v.1.10.0)
v2: Ruby 2.7.1, Rails 6.0.3.2
```
## Development
``
$ chruby 2.7.1
$ bundle gem zt_admin
```
Then update files:
```
  lib/zt_admin.rb, bin/zt_admin, zt_admin.gemspec, .gitignore
```
## Run
```
$ rm zt_admin*.gem; git add .; gem build zt_admin.gemspec; $ sudo gem install --local zt_admin-2.3.0.gem
```
$ bin/zt_admin

## Uninstal gem

$ gem uninstall -i /Users/zhenya/.rubies/ruby-2.7.1/lib/ruby/gems/2.7.0 zt_admin

## Admin Development

$ rails g controller sessions new

. . .

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Issues to be solved
