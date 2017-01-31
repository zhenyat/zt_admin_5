################################################################################
#   setpar.rb
#     Initializes parameters for the gem
#
#   23.01.2017  ZT
################################################################################

# Constants
BLACK   = 'black'
BLUE    = 'blue'
CYAN    = 'cyan'
GRAY    = 'grey'
GREY    = 'gray'
GREEN   = 'green'
MAGENTA = 'magenta'
RED     = 'red'
WHITE   = 'white'
YELLOW  = 'yellow'

TAB   = '  '        # Two spaces - to be used instead of \t
TAB2  = TAB  * 2
TAB3  = TAB2 + TAB
TAB4  = TAB  * 4
TAB5  = TAB4 + TAB
TAB6  = TAB  * 6

# Special attribute cases (identified in *get_attributes*)
$references_names    = []
$password_attribute  = nil

# Enumerated options
$enum = []

# Debug flag
$debug = false

module ZtAdmin

  AppRoot          = `pwd`.chomp    # chomp without arguments removes "\n" or "\r\n" if any
  MigratePath      = "#{AppRoot}/db/migrate"
  ModelPath        = "#{AppRoot}/app/models"
  AdminSharedPath  = "#{AppRoot}/app/views/admin/shared"

  AppName = AppRoot.split('/').last.split('_').map{|e| e.capitalize}.join

  def self.root
    File.dirname(__dir__).chomp("/lib")
  end

  def self.assets
    File.join root, 'generic', 'app', 'assets'
  end

  def self.bin
    File.join root, 'bin'
  end

  def self.config
    File.join root, 'generic', 'config'
  end

  def self.controllers
    File.join root, 'generic', 'app', 'controllers'
  end

  def self.db
    File.join root, 'generic', 'db'
  end

  def self.generic
    File.join root, 'generic'
  end

  def self.helpers
    File.join root, 'generic', 'app', 'helpers'
  end

  def self.lib
    File.join root, 'generic', 'lib'
  end

  def self.models
    File.join root, 'generic', 'app', 'models'
  end

  def self.policies
    File.join root, 'generic', 'app', 'policies'
  end

  def self.views
    File.join root, 'generic', 'app', 'views'
  end

  def self.vendor
    File.join root, 'generic', 'vendor'
  end
end
