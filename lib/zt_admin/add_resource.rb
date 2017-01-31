################################################################################
#   add_resource
#     Generates a Model resources in Admin namespace
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
      if line.match("1: Add new admin resources")     # MULTILINGUAL Admin namespace
        file_out.puts "#{TAB4}resources :#{$names}"
      elsif line.match("2: Add new admin resources")  # Standard Admin namespace
        file_out.puts "#{TAB3}resources :#{$names}"
      end
      file_out.puts line                              # Just copy an original line
    end
    file_out.close

    FileUtils.rm "#{AppRoot}/config/routes_backup.rb" # Remove backup file

  rescue Exception => error
    puts colored(RED, 'ACHTUNG! Something went wrong during adding resorce process...')
    puts colored(RED, error.message)
  end
end