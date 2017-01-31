#!/usr/bin/env ruby
#################################################################################
#   view_show.rb
#
#   Generates View file: admin/views/<model>/show.html.haml
#
#   05.03.2015  ZT (for bkc_admin)
#   06.07.2016  Copied for zt_admin
#   02.08.2016  Updated with bootstrap
#   03.08.2016  Bugs fixed
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/show.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/show.html.haml", 'w')

  #file.puts "%p#notice= notice\n\n"
  file.puts "%h1= t #{$model}.model_name.human"

  file.puts "%table.table.table-striped\n#{TAB}%tbody"
  file.puts "#{TAB2}- @#{$name}.attributes.each do |key, value|"

  file.puts "#{TAB3}- if key == 'id' || key.include?('digest') || key == 'created_at' || key == 'updated_at'"
  file.puts"#{TAB4}//skip these attributes"
  file.puts"#{TAB3}-else"
  file.puts"#{TAB4}%tr"
  file.puts"#{TAB5}- if key == 'status'"
  file.puts"#{TAB6}%td= t 'status.status'"
  file.puts"#{TAB6}%td= status_mark @#{$name}.status"
  file.puts"#{TAB5}-else"
  file.puts"#{TAB6}%td= t " << '"activerecord.attributes.' << "#{$name}." << '#{key}"'
  file.puts"#{TAB6}%td= value"

  file.puts "\n.form_actions"
  file.puts "#{TAB}.row\n#{TAB2}.col-md-2"
  file.puts "#{TAB3}= link_to t('actions.back'), admin_#{$names}_path, class: 'btn btn-primary btn-block'"

  file.close
end