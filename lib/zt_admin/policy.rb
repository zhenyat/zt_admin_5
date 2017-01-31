#! /usr/bin/env ruby
################################################################################
#   policy.rb
#
#   Generates policy file for a Model
#
#   30.01.2017  ZT
################################################################################

module ZtAdmin
  relative_path = "app/policies/#{$name}_policy.rb"
  absolute_path = "#{AppRoot}/#{relative_path}"

  action_report relative_path
  file = File.open(absolute_path, 'w')

  file.puts "class #{$model}Policy < ApplicationPolicy"

  file.puts "\n#{TAB}# For index"
  file.puts "#{TAB}class Scope < Scope"
  file.puts "#{TAB2}def resolve"
  file.puts "#{TAB3}if (user.sysadmin? || user.admin? || user.manager?)\n#{TAB4}scope.all\n#{TAB4}else\n#{TAB4}nil\n#{TAB3}end"
  file.puts "#{TAB2}end"
  file.puts "#{TAB}end"

  file.puts "\n#{TAB}def show?\n#{TAB2}user.sysadmin? || user.admin? || user.manager?\n#{TAB}end"
  file.puts "\n#{TAB}def create?\n#{TAB2}user.sysadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def new?\n#{TAB2}create?\n#{TAB}end"
  file.puts "\n#{TAB}def edit?\n#{TAB2}user.sysadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def update?\n#{TAB2}user.sysadmin? || user.admin?\n#{TAB}end"
  file.puts "\n#{TAB}def destroy?\n#{TAB2}user.sysadmin? || user.admin?\n#{TAB}end"

  file.puts "end"
  file.close
end
