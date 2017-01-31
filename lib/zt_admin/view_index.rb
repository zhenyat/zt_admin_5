#!/usr/bin/env ruby
#################################################################################
#   view_index.rb
#
#   Generates View file: admin/views/<models>/index.html.haml
#
#   05.03.2015  ZT (for bkc_admin)
#   09.07.2016  Updated for zt_admin
#   02.08.2016  Updated with better model localization
#   03.02.2016  Bug fixed
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/index.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/index.html.haml", 'w')

  #file.puts "\n%h1= t('actions.listing', model: @#{$names}.first.class.model_name.human)\n"    # Page Title
  file.puts "%h1= t #{$model}.model_name.human(count: 2)"    # Page Title

  # Table heads line
  file.puts "%table.table.table-hover\n#{TAB}%thead\n#{TAB2}%tr"

  $attr_names.each do |attr_name|
  #  file.puts "#{TAB3}%th= " << '"#{@' << "#{$names}.first.class.human_attribute_name(:#{attr_name})" << '}"' unless attr_name.include?('password') || attr_name.include?('remember') || attr_name.include?('status')
    file.puts "#{TAB3}%th= " << "#{$model}.human_attribute_name(:#{attr_name})" unless attr_name.include?('password') || attr_name.include?('remember') || attr_name.include?('status')
  end
  file.puts "#{TAB3}%th= t 'status.status'"
  file.puts "#{TAB3}%th= t 'actions.actions'"

  #Table body
  file.puts "\n  %tbody"
  file.puts "    - @#{$names}.each do |#{$name}|"
  file.puts "      %tr"
  $attr_names.each_with_index do |attr_name, index|
    if $attr_types[index] == 'references'
      file.puts "        %td= #{$name}.#{attr_name}.title"
    else
      if attr_name == 'status'
        file.puts "        %td= status_mark #{$name}.#{attr_name}"
      else
        file.puts "        %td= #{$name}.#{attr_name}" unless attr_name.include?('password') || attr_name.include?('remember')
      end
    end
  end
  file.puts "#{TAB4}%td= render 'admin/shared/index_buttons', resource: #{$name}"

  file.puts "%br\n.row\n#{TAB}.col-md-2"
  file.puts "#{TAB2}= link_to t('actions.create'), new_admin_#{$name}_path, class: 'btn btn-primary btn-block'"

  file.close
end