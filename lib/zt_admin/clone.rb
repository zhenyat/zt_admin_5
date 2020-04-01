################################################################################
#   clone.rb
#
#   Clones generic files to the App
#
#   26.01.2017  ZT
#   12.04.2017  1.2.0   Workaround *vendor* *assets* for RoR 5.1.x
#               1.2.1   Bugs fixed
################################################################################
module ZtAdmin

  # Creates a directory for the App
  def self.create_dir dirname
    action_report dirname
    unless File.exist?  "#{AppRoot}/#{dirname}"
      FileUtils.mkdir_p "#{AppRoot}/#{dirname}"
    end
  end

  begin
    ### *root* directory  ###
    puts colored(GREY, "#{TAB}invoke     Application root directory")

    FileUtils.cp "#{generic}/gitignore", "#{AppRoot}/.gitignore"
    action_report ".gitignore"

    ### *config* directory   ###
    action_report "config"

    # File: config/application.rb
    fin  = File.open "#{config}/application.rb", "r"
    fout = File.open "#{AppRoot}/config/application.rb", "w"

    fin.each_line do |line|
      if line =~ /module Dummy/ then
        new_line = "module #{AppName}"
        fout.puts new_line            # Replace the line with *Dummy* App Name
      else
        fout.puts line                # Just copy a line
      end
    end
    fin.close
    fout.close
    action_report "config/application.rb"

    unless File.exists? "#{AppRoot}/config/routes_original.rb"
      action_report "config/routes_original.rb"
      FileUtils.mv "#{AppRoot}/config/routes.rb", "#{AppRoot}/config/routes_original.rb"
    end

    FileUtils.cp "#{config}/routes.rb", "#{AppRoot}/config"
    action_report "config/routes.rb"

    # zt_config directory
    create_dir  "config/zt_config"
    FileUtils.cp_r "#{config}/zt_config", "#{AppRoot}/config"

    # initializers directory
    action_report "config/initializers"

    action_report "config/initializers/git_info.rb"
    FileUtils.cp "#{config}/initializers/git_info.rb", "#{AppRoot}/config/initializers"

    action_report "config/initializers/zt_load.rb"
    FileUtils.cp "#{config}/initializers/zt_load.rb", "#{AppRoot}/config/initializers"

    ###   Locales
    # Directory: config/locales/defaults
    create_dir "config/locales/defaults"
    FileUtils.cp_r "#{config}/locales/defaults", "#{AppRoot}/config/locales"

    # Directory: config/locales/models
    create_dir "config/locales/models"
    FileUtils.cp_r "#{config}/locales/models", "#{AppRoot}/config/locales"

    # Directory: config/locales/views
    create_dir "config/locales/views"
    FileUtils.cp_r "#{config}/locales/views", "#{AppRoot}/config/locales"

    # Simple Form locales
    action_report "config/locales"
    FileUtils.cp "#{config}/locales/simple_form.en.yml", "#{AppRoot}/config/locales"
    FileUtils.cp "#{config}/locales/simple_form.ru.yml", "#{AppRoot}/config/locales"

    if File.exist? "#{AppRoot}/config/locales/en.yml"
      FileUtils.rm_f "#{AppRoot}/config/locales/en.yml"
      puts colored(RED,  "#{TAB}remove     ")  + "config/locales/en.yml"
    end

    ### Get generic files in the *lib* directory
    action_report "lib"

    action_report "lib/templates"
    create_dir "lib/templates"
    FileUtils.cp_r "#{lib}/templates", "#{AppRoot}/lib"

    # Remove either *erb* or *haml* template
    if `gem list -i haml-rails` == "true\n"
      action_report "lib/template/haml"
      FileUtils.rm_rf "#{AppRoot}/lib/templates/erb"
    else
      action_report "lib/template/erb"
      FileUtils.rm_rf "#{AppRoot}/lib/templates/haml"
    end

  ### Get generic files in the *vendor* directory
    action_report "vendor"

    # Workaround for RoR 5.1.x
    FileUtils.mkdir "#{AppRoot}/vendor/assets"             unless Dir.exist?("#{AppRoot}/vendor/assets")
    FileUtils.mkdir "#{AppRoot}/vendor/assets/javascripts" unless Dir.exist?("#{AppRoot}/vendor/assets/javascripts")
    FileUtils.mkdir "#{AppRoot}/vendor/assets/stylesheets" unless Dir.exist?("#{AppRoot}/vendor/assets/stylesheets")
    
    action_report "vendor/assets/javascripts/rainbow.js"
    FileUtils.cp "#{vendor}/assets/javascripts/rainbow.js", "#{AppRoot}/vendor/assets/javascripts"
    action_report "vendor/javascripts/ruby.js"
    FileUtils.cp "#{vendor}/assets/javascripts/ruby.js",    "#{AppRoot}/vendor/assets/javascripts"

    action_report "vendor/assets/stylesheets/github.css"
    FileUtils.cp "#{vendor}/assets/stylesheets/github.css", "#{AppRoot}/vendor/assets/stylesheets"

    ####    db    ####
    action_report "db"

    action_report "db/seeds.rb"
    FileUtils.cp "#{db}/seeds.rb", "#{AppRoot}/db"

    ### Get generic files in the *migrate* directory
    create_dir "db/migrate"
    current_dt = Time.now
    timestamp  = current_dt.strftime("%Y%m%d") + (current_dt.to_i/10000).to_s
    action_report "db/migrate/#{timestamp}_create_users.rb"
    FileUtils.cp "#{db}/migrate/TIMESTAMP_create_users.rb", "#{AppRoot}/db/migrate/#{timestamp}_create_users.rb"

    ####    App   ####

    ### Get generic files in the *assets* directory
    action_report "app/assets"

    action_report "app/assets/javascripts/application.js"
    FileUtils.cp "#{assets}/javascripts/application.js", "#{AppRoot}/app/assets/javascripts"

    action_report "app/assets/stylesheets/application.css.scss"
    FileUtils.cp "#{assets}/stylesheets/application.css.scss", "#{AppRoot}/app/assets/stylesheets"

    if File.exist? "#{AppRoot}/app/assets/stylesheets/application.css"
      FileUtils.rm_f "#{AppRoot}/app/assets/stylesheets/application.css"
      puts colored(RED,  "#{TAB}remove     ")  + "app/assets/stylesheets/application.css"
    end

    action_report "app/assets/images"
    FileUtils.cp_r "#{assets}/images", "#{AppRoot}/app/assets"


    ### Get generic files in the *Models* directory
    action_report "app/models"

    action_report "app/models/user.rb"
    FileUtils.cp "#{models}/user.rb", "#{AppRoot}/app/models"

    ### Get generic files in the *Controllers* directory
    action_report "app/controllers"

    action_report "app/controllers/admin"
    create_dir "app/controllers/admin"

    action_report "app/controllers/admin/base_controller.rb"
    FileUtils.cp "#{controllers}/admin/base_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/admin/panel_controller.rb"
    FileUtils.cp "#{controllers}/admin/panel_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/admin/users_controller.rb"
    FileUtils.cp "#{controllers}/admin/users_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/concerns"
    FileUtils.cp_r "#{controllers}/concerns", "#{AppRoot}/app/controllers"

    action_report "app/controllers/application_controller.rb"
    FileUtils.cp "#{controllers}/application_controller.rb", "#{AppRoot}/app/controllers"

    action_report "app/controllers/sessions_controller.rb"
    FileUtils.cp "#{controllers}/sessions_controller.rb", "#{AppRoot}/app/controllers"

    action_report "app/controllers/pages_controller.rb"
    FileUtils.cp "#{controllers}/pages_controller.rb", "#{AppRoot}/app/controllers"

    ### Get generic files in the *helpers* directory
    action_report "app/helpers"

    action_report "app/helpers/admin"
    create_dir "app/helpers/admin"
    FileUtils.cp_r "#{helpers}/admin", "#{AppRoot}/app/helpers"

    action_report "app/helpers/application_helper.rb"
    FileUtils.cp "#{helpers}/application_helper.rb", "#{AppRoot}/app/helpers"

    action_report "app/helpers/sessions_helper.rb"
    FileUtils.cp "#{helpers}/sessions_helper.rb", "#{AppRoot}/app/helpers"

    ### Get generic files in the *policies* directory
    action_report "app/policies"

    action_report "app/policies/panel_policy.rb"
    FileUtils.cp "#{policies}/panel_policy.rb", "#{AppRoot}/app/policies"

    action_report "app/policies/user_policy.rb"
    FileUtils.cp "#{policies}/user_policy.rb", "#{AppRoot}/app/policies"

    ### Get generic files in the *views* directory
    action_report "app/views"

    action_report "app/views/layouts"
    FileUtils.cp_r "#{views}/layouts", "#{AppRoot}/app/views"

    # Update app/views/layouts/application.rb (App name)
    action_report "app/views/layouts/application.html.erb"
    fin  = File.open "#{views}/layouts/application.html.erb", "r"
    fout = File.open "#{AppRoot}/app/views/layouts/application.html.erb", "w"

    fin.each_line do |line|
      if line =~ /Dummy/ then
        new_line = "<title>#{AppName}</title>"
        fout.puts new_line                # Replace the line with Dummy App Name
      else
        fout.puts line                    # Just copy a line
      end
    end
    fin.close
    fout.close

    # Directory *sessions*
    create_dir "app/views/sessions"
    FileUtils.cp_r "#{views}/sessions", "#{AppRoot}/app/views/"

    # Directory *pages*
    create_dir "app/views/pages"
    FileUtils.cp_r "#{views}/pages", "#{AppRoot}/app/views/"

    # Directory *shared*
    create_dir "app/views/shared"
    FileUtils.cp_r "#{views}/shared", "#{AppRoot}/app/views/"

    # Directory *admin*
    create_dir "app/views/admin/"
    FileUtils.cp_r "#{views}/admin", "#{AppRoot}/app/views/"

    puts colored(MAGENTA, "\n#{TAB}Run commands now (to create db table 'users'):")
    puts colored(MAGENTA, "#{TAB2}rails db:migrate")
    puts colored(MAGENTA, "#{TAB2}rails db:seed")

  rescue Exception => error
    puts colored(RED, "\nACHTUNG! Something went wrong during cloning process...")
    puts colored(RED, error.message)
  end
end
