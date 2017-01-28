################################################################################
#   command_parser.rb
#     Command line options analysis on a base of Ruby OptionParser class
#
#     ref: http://ruby-doc.org/stdlib-2.2.0/libdoc/optparse/rdoc/OptionParser.html#top
#
#   16.01.2017  ZT
################################################################################
require 'optparse'
require 'optparse/time'
require 'ostruct'

include ZtMethods

module ZtAdmin
  class OptparseCommand

    # Returns a structure describing the Command options
    def self.parse(args)
      if args.size == 0
        puts colored RED, "Not enough arguments. To learn the command use options: -h or --help"
        exit
      end

      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.enum = []

      opt_parser = OptionParser.new do |opts|
        opts.banner  = "\nUsage:#{TAB2}zt_admin [i | init]     - Gemfile to be updated for further `bundle install`"
        opts.banner << "\n#{TAB5}zt_admin [c | clone]    - generic files to be added"
        opts.banner << "\n#{TAB5}zt_admin [g | generate] <model_name> [options]"
        opts.banner << "\n#{TAB5}zt_admin {d | destroy} <model_name>"
        opts.banner << "\n\nExamples: zt_admin g User -e role -d\n#{TAB5}zt_admin destroy User"

        opts.separator ""
        opts.separator "Specific options:"

        # Mandatory argument.
        opts.on("-e", "--enum ENUMERATED ATTRIBUTE",
                "Requires the Model enum attribute for input field in a view form") do |enum|
          options.enum << enum
        end

        opts.separator ""
        opts.separator "Common options:"

        # Debug flag: no arguments
        opts.on("-d", "--debug", "Debug printing is ON") do
          $debug = true
        end

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("-v", "--version", "Show version") do
          puts VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end           # parse()
  end             # class OptparseCommand
end