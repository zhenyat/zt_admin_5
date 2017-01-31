#!/usr/bin/env ruby
################################################################################
#   Deletes Admin files for a given Model
#
#   30.01.2017  ZT (Adopted from bkc_admin)
################################################################################

module ZtAdmin
  # Delete controller
  relative_path = 'app/controllers/admin'
  admin_path    = "#{AppRoot}/#{relative_path}"

  if File.exist? admin_path
    file = "#{admin_path}/#{$names}_controller.rb"
    if File.exist? file
      File.delete file
      puts colored(RED,  "#{TAB}remove     ") + "#{relative_path}/#{$names}_controller.rb"
    end
  end

  # Delete views
  view_relative_path = 'app/views/admin'
  views_path    = "#{AppRoot}/#{view_relative_path}/#{$names}"

  if File.exist? views_path
    FileUtils.rm_r views_path
    puts colored(RED,  "#{TAB}remove     ") + "#{view_relative_path}/#{$names}"
  end

  # Delete Model helpers
  helper_file   = "app/helpers/admin/#{$names}_helper.rb"
  absolute_path = "#{AppRoot}/#{helper_file}"

  if File.exist?(absolute_path)
    File.delete absolute_path
    puts colored(RED,  "#{TAB}remove     ") + "#{helper_file}"
  end

  # Delete everything if no more models in Admin
  if File.exist?(admin_path) && Dir.glob("#{admin_path}/*").empty?
    Dir.rmdir admin_path
    puts colored(RED,  "#{TAB}remove     ") + "#{relative_path}"

    view_admin_path = "#{AppRoot}/#{view_relative_path}"
    if File.exists?(view_admin_path) && Dir.glob("#{view_admin_path}/*").empty?
      Dir.rmdir view_admin_path
      puts colored(RED,  "#{TAB}remove     ") + "#{view_relative_path}"
    end

    # Delete admin directory for helpers
    if Dir.glob("#{helper_admin_path}/*").empty?
      Dir.rmdir helper_admin_path
      puts colored(RED,  "#{TAB}remove     ") + "#{helper_relative_path}"
    end

    # Delete Admin assets
    pathes = ["app/assets/images/admin",
              "app/assets/images/buttons",
              "app/assets/stylesheets/admin",
              "app/assets/javascripts/admin"
             ]

    pathes.each do |path|
      if File.exist? "#{AppRoot}/#{path}"
        FileUtils.rm_rf "#{AppRoot}/#{path}"
        puts colored(RED,  "#{TAB}remove     ") + "#{path}"
      end
    end

  #  relative_images_path = "app/assets/images/admin"
  #  FileUtils.rm_rf "#{AppRoot}/#{relative_images_path}"
  #  puts colored(RED,  "#{TAB}remove     ") + "#{relative_images_path}"
  #
  #  relative_images_path = "app/assets/images/buttons"
  #  FileUtils.rm_rf "#{AppRoot}/#{relative_images_path}"
  #  puts colored(RED,  "#{TAB}remove     ") + "#{relative_images_path}"
  #
  #  relative_images_path = "app/assets/stylesheets/admin"
  #  FileUtils.rm_rf "#{AppRoot}/#{relative_images_path}"
  #  puts colored(RED,  "#{TAB}remove     ") + "#{relative_images_path}"
  end
end
