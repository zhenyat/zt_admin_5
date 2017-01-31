################################################################################
#   zt_admin.rb
#     Main Module to create / update / destroy directories and files
#
#   29.01.2017  ZT
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
  get_names options                           # Model names & $mode

  if $mode == 'init'
    require 'zt_admin/init'                   # Initial step

  elsif $mode == 'clone'                      # Cloning step
    require 'zt_admin/clone'                  # Copy Generic files

  elsif $mode == 'generate'                   # Generate Admin directories and files

    if $model == "User"
      puts colored RED, "The model User has been already generated!"
      exit
    end

    get_attributes

    require 'zt_admin/controller'             # Admin Controller
    require 'zt_admin/add_resource'           # Update config/routes.rb file
    require 'zt_admin/policy'                 # Generate policy file

    create_views_path                         # Generate Admin Views for the Model
    require 'zt_admin/view_index'             # View:     index
    require 'zt_admin/view_show'              # View:     show
    require 'zt_admin/view_new'               # View:     new
    require 'zt_admin/view_edit'              # View:     edit
    require 'zt_admin/view_form'              # Partial: _form

  else                                        # Destroy Admin files and directories
    if $model == "User"
      puts colored RED, "The model User can't be destroyed!"
      exit
    end

    require 'zt_admin/destroy'                # Destroy files and directories
    require 'zt_admin/remove_resource'        # Remove resource from config/routes.rb file
  end

  debug_printing options if $debug
  exit

  # Test sample
  class Sample
    def say_hello
      puts 'Hello! Just first test'
    end
  end

end
