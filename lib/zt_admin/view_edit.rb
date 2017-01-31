#!/usr/bin/env ruby
#################################################################################
#   view_edit.rb
#
#   Generates View file: admin/views/<model>/edit.html.haml
#
#   23.02.2015  ZT (for bkc_admin)
#   06.07.2016  Copied for zt_admin
#   02.08.2016  Updated for bootstrap
#   03.08.2016  Bug fixed
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/edit.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/edit.html.haml", 'w')

  file.puts '%h1= "#{' << "t('actions.editing', model: @#{$name}.class.model_name.human)" << '}"'
  file.puts "= render 'form'"

  file.close
end