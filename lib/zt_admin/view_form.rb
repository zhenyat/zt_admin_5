#!/usr/bin/env ruby
################################################################################
#   view_form.rb
#
#   Generates partial file: admin/views/<models>/_form.html.haml
#
#   23.02.2015  ZT (bkc_admin)
#   09.07.2016  Updated for zt_admin
#   21.07.2016  no blank option for DDL
#   02.08.2016  Final update for bootstrap
#   03.08.2016  Bug fixed
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/_form.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/_form.html.haml", 'w')

  file.puts ".row"
  file.puts "#{TAB}.col-md-6"
  file.puts "#{TAB2}= simple_form_for([:admin, @#{$name}], html: {multipart: true}) do |f|"

  # Errors block
  file.puts "#{TAB3}= f.error_notification message: t('messages.error_notification')"

  # Input fields
  file.puts "\n#{TAB3}.form-inputs"

  $attr_names.each_with_index do |attr_name|
    if attr_name.match 'password'
      file.puts "#{TAB4}= f.input :password"
      file.puts "#{TAB4}= f.input :password_confirmation"
    elsif attr_name.match 'remember_digest'
      # skip the attribute
    elsif attr_name.match 'position'
      file.puts "#{TAB4}= f.input :#{attr_name}, as: :hidden"
    elsif attr_name.match 'status'
      file.puts "\n#{TAB4}= f.input :status, default: 1"
     file.puts "#{TAB4}/= render 'admin/shared/status_buttons', f: f"
    else
      if $enum.include?(attr_name)
        file.puts "#{TAB4}= f.input :#{attr_name}, include_blank: false"
      else
        file.puts "#{TAB4}= f.input :#{attr_name}"
      end

    end
  end

  file.puts "\n#{TAB3}.form_actions"
  file.puts "#{TAB4}.row"

  file.puts "#{TAB5}.col-md-3"
  file.puts "#{TAB6}= f.submit t('actions.save'), class: 'btn btn-primary btn-block'"

  #file.puts "#{TAB5}.col-md-3"
  #file.puts "#{TAB6}= link_to t('actions.save'), admin_#{$name}_path, class: 'btn btn-info btn-block' unless @#{$name}.new_record?"

  file.puts "#{TAB5}.col-md-3"
  file.puts "#{TAB6}= link_to t('actions.back'), admin_#{$names}_path, class: 'btn btn-default btn-block'"

  file.close
end