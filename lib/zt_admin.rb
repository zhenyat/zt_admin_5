################################################################################
#   zt_admin.rb
#     Main Module to generate / update / destroy directories and files
#
#   22.01.2017  Updated (with test)
#   23.01.2017  Generic processe added
################################################################################
require 'zt_admin/version'
require 'zt_admin/setpar'
require 'active_support/inflector'   # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
require 'zt_admin/methods_pool'
require 'zt_admin/command_parser'
require 'pp'
require 'active_support/dependencies/autoload'

module ZtAdmin
  options = OptparseCommand.parse(ARGV)
  ZtMethods.get_names options

  if $mode == 'init'
    require 'zt_admin/init'                   # Initial step

  elsif $mode == 'clone'                      # Generate Admin directories and files
    require 'zt_admin/clone'                  # Copy Generic files

  elsif $mode == 'generate'                   # Generate Admin directories and files

    ZtMethods.get_attributes                  # Handle Model attributes from a migration file
    require 'zt_admin/controller'             # Admin Controller
    require 'zt_admin/authentication'         # Concerns Controller & Updates application_controller
  ZtMethods.debug_printing options if $debug
  exit
#    require 'zt_admin/helper'                 # Admin Helpers
    require 'zt_admin/add_resource'           # Update config/routes.rb file

    create_views_path                         # Generate Admin Views for the Model
    require 'zt_admin/view_index'             # View:     index
    require 'zt_admin/view_show'              # View:     show
    require 'zt_admin/view_new'               # View:     new
    require 'zt_admin/view_edit'              # View:     edit
    require 'zt_admin/view_form'              # Partial: _form

    require 'zt_admin/add_assets'             # Assets for Admin

    require 'zt_admin/add_shared'             # Files in shared directory

  else                                          # Destroy Admin files and directories
    require 'zt_admin/destroy'                # Destroy files and directories
    require 'zt_admin/remove_resource'        # Remove resource from config/routes.rb file
    require 'zt_admin/remove_authentication'  # Update application_controller.rb
  end

  ZtMethods.debug_printing options if $debug
  exit

  # Test sample
  class Sample
    def say_hello
      puts 'Hello! Just first test'
    end
  end

end
