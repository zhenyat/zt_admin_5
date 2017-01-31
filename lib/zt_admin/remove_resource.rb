################################################################################
#   add_resource
#     Remove a Model resources from Admin namespace
#
#   30.01.2017  ZT
################################################################################
module ZtAdmin
  begin
    # Read original lines
    file_in  = File.open "#{AppRoot}/config/routes.rb", "r"
    lines    = file_in.readlines
    file_in.close

    action_report "config/routes.rb"

    # Back up the existing file
    FileUtils.mv "#{AppRoot}/config/routes.rb", "#{AppRoot}/config/routes_backup.rb"

    file_out = File.open "#{AppRoot}/config/routes.rb", "w"   # Create new file
    lines.each do |line|
      file_out.puts line unless line.match("resources :#{$names}")
    end
    file_out.close

    FileUtils.rm "#{AppRoot}/config/routes_backup.rb" # Remove backup file

  rescue Exception => error
    puts colored(RED, "\nACHTUNG! Something went wrong during removing resorces process...")
    puts colored(RED, error.message)
  end
end