################################################################################
#   clone.rb
#
#   Clones generic files to the App
#
#   26.01.2017  ZT
################################################################################
module ZtAdmin

  # Creates a directory for the App
  def self.create_dir dirname
    unless File.exist?  "#{AppRoot}/#{dirname}"
      FileUtils.mkdir_p "#{AppRoot}/#{dirname}"
      puts colored GREEN, "#{TAB2}Directory #{dirname} has been created"
    end
  end

  begin
    ### *root* directory  ###
    puts colored BLUE, "#{TAB}App root directory to be updated..."

    FileUtils.cp "#{generic}/gitignore", "#{AppRoot}/.gitignore"
    puts colored GREEN, "#{TAB2}File .gitignore has been updated"

    ### *config* directory   ###
    puts colored BLUE, "#{TAB}config directory to be updated..."

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
    puts colored GREEN, "#{TAB2}File app/config/application.rb has been updated"

    FileUtils.mv "#{AppRoot}/config/routes.rb", "#{AppRoot}/config/routes_original.rb" unless File.exists? "#{AppRoot}/config/routes_original.rb"
    FileUtils.cp "#{config}/routes.rb", "#{AppRoot}/config"
    puts colored GREEN, "#{TAB2}File config/routes.rb has been updated"

    # zt_config directory
    create_dir  "config/zt_config"
    FileUtils.cp_r "#{config}/zt_config", "#{AppRoot}/config"
    puts colored GREEN, "#{TAB2}Files have been copied to config/zt_config"

    # initializers directory
    FileUtils.cp "#{config}/initializers/git_info.rb", "#{AppRoot}/config/initializers"
    puts colored GREEN, "#{TAB2}File config/initializers/git_info.rb has been created"

    FileUtils.cp "#{config}/initializers/zt_load.rb", "#{AppRoot}/config/initializers"
    puts colored GREEN, "#{TAB2}File config/initializers/zt_load.rb has been created"

    ###   Locales
    # Directory: config/locales/defaults
    create_dir "config/locales/defaults"
    FileUtils.cp_r "#{config}/locales/defaults", "#{AppRoot}/config/locales"
    puts colored GREEN, "#{TAB2}Files have been copied to config/locales/defaults"

    # Directory: config/locales/models
    create_dir "config/locales/models"
    FileUtils.cp_r "#{config}/locales/models", "#{AppRoot}/config/locales"
    puts colored GREEN, "#{TAB2}Files have been copied to config/locales/models"

    # Directory: config/locales/views
    create_dir "#{config}/locales/views"
    FileUtils.cp_r "#{config}/locales/views", "#{AppRoot}/config/locales"
    puts colored GREEN, "#{TAB2}Files have been copied to config/locales/views"

    # Simple Form locales
    FileUtils.cp "#{config}/locales/simple_form.en.yml", "#{AppRoot}/config/locales"
    FileUtils.cp "#{config}/locales/simple_form.ru.yml", "#{AppRoot}/config/locales"
    puts colored GREEN, "#{TAB2}SimpleForm locales (en & ru) have been updated"

    if File.exist? "#{AppRoot}/config/locales/en.yml"
      FileUtils.rm_f "#{AppRoot}/config/locales/en.yml"
      puts colored RED,  "#{TAB2}File config/locales/en.yml have been removed"
    end

    ### Get generic files in the *lib* directory
    puts colored BLUE, "#{TAB}lib directory to be updated..."

    create_dir "lib/templates"
    FileUtils.cp_r "#{lib}/templates", "#{AppRoot}/lib"
    puts colored GREEN, "#{TAB2}Files have been copied to lib/templates"

    # Remove either *erb* or *haml* template
    if `gem list -i haml-rails` == "true\n"
      FileUtils.rm_rf "#{AppRoot}/lib/templates/erb"
      puts colored GREEN, "#{TAB2}HAML templates have been copied"
    else
      FileUtils.rm_rf "#{AppRoot}/lib/templates/haml"
      puts colored GREEN, "#{TAB2}ERB templates have been copied"
    end

    ### Get generic files in the *assets* directory
    puts colored BLUE, "#{TAB}app/assets directory to be updated..."

    FileUtils.cp "#{assets}/javascripts/application.js", "#{AppRoot}/app/assets/javascripts"
    puts colored GREEN, "#{TAB2}File app/assets/javascripts/application.js has been updated"

    FileUtils.cp "#{assets}/stylesheets/application.css.scss", "#{AppRoot}/app/assets/stylesheets"
    puts colored GREEN, "#{TAB2}File app/assets/stylesheets/application.css.scss has been created"

    if File.exist? "#{AppRoot}/app/assets/stylesheets/application.css"
      FileUtils.rm_f "#{AppRoot}/app/assets/stylesheets/application.css"
      puts colored RED,  "#{TAB2}File app/assets/stylesheets/application.css has been removed"
    end

    FileUtils.cp_r "#{assets}/images", "#{AppRoot}/app/assets"
    puts colored GREEN, "#{TAB2}Directory app/assets/images/ has been updated"

    ### Get generic files in the *vendor* directory
    puts colored BLUE, "#{TAB}vendor directory to be updated..."

    FileUtils.cp "#{vendor}/assets/javascripts/rainbow.js", "#{AppRoot}/vendor/assets/javascripts"
    puts colored GREEN, "#{TAB2}File vendor/assets/javascripts/rainbow.js has been added"

    FileUtils.cp "#{vendor}/assets/javascripts/ruby.js", "#{AppRoot}/vendor/assets/javascripts"
    puts colored GREEN, "#{TAB2}File vendor/assets/javascripts/ruby.js has been added"

    FileUtils.cp "#{vendor}/assets/stylesheets/github.css", "#{AppRoot}/vendor/assets/stylesheets"
    puts colored GREEN, "#{TAB2}File vendor/assets/stylesheets/github.css has been added"

    ####    db    ####
    puts colored BLUE, "#{TAB}db directory to be updated..."

    FileUtils.cp "#{db}/seeds.rb", "#{AppRoot}/db"
    puts colored GREEN, "#{TAB2}File #{db}/seeds.rb has been copied to db"

    ### Get generic files in the *migrate* directory
    create_dir "db/migrate"
    current_dt = Time.now
    timestamp  = current_dt.strftime("%Y%m%d") + (current_dt.to_i/10000).to_s
    FileUtils.cp "#{db}/migrate/TIMESTAMP_create_users.rb", "#{AppRoot}/db/migrate/#{timestamp}_create_users.rb"
    puts colored GREEN, "#{TAB2}File #{timestamp}_create_users.rb has been created at db/migrate"

    ####    App   ####

    ### Get generic files in the *Models* directory
    puts colored BLUE, "#{TAB}app/models directory to be updated..."

    FileUtils.cp "#{models}/user.rb", "#{AppRoot}/app/models"
    puts colored GREEN, "#{TAB2}File user.rb has been copied to app/models"

    ### Get generic files in the *Controllers* directory
    puts colored BLUE, "#{TAB}app/controllers directory to be updated..."

    create_dir "app/controllers/admin"

    FileUtils.cp "#{controllers}/admin/base_controller.rb", "#{AppRoot}/app/controllers/admin"
    puts colored GREEN, "#{TAB2}File base_controller.rb has been copied to app/controllers/admin"

    FileUtils.cp "#{controllers}/admin/panel_controller.rb", "#{AppRoot}/app/controllers/admin"
    puts colored GREEN, "#{TAB2}File panel_controller.rb has been copied to app/controllers/admin"

    FileUtils.cp "#{controllers}/admin/users_controller.rb", "#{AppRoot}/app/controllers/admin"
    puts colored GREEN, "#{TAB2}File users_controller.rb has been copied to app/controllers/admin"

    FileUtils.cp_r "#{controllers}/concerns", "#{AppRoot}/app/controllers"
    puts colored GREEN, "#{TAB2}Directory app/controllers/concerns has been updated"

    FileUtils.cp "#{controllers}/application_controller.rb", "#{AppRoot}/app/controllers"
    puts colored GREEN, "#{TAB2}File app/controllers/application_controller.rb has been updated"

    FileUtils.cp "#{controllers}/sessions_controller.rb", "#{AppRoot}/app/controllers"
    puts colored GREEN, "#{TAB2}File app/controllers/sessions_controller.rb has been added"

    FileUtils.cp "#{controllers}/pages_controller.rb", "#{AppRoot}/app/controllers"
    puts colored GREEN, "#{TAB2}File app/controllers/pages_controller.rb has been added"

    ### Get generic files in the *helpers* directory
    puts colored BLUE, "#{TAB}app/helpers directory to be updated..."

    create_dir "app/helpers/admin"
    FileUtils.cp_r "#{helpers}/admin", "#{AppRoot}/app/helpers"
    puts colored GREEN, "#{TAB2}Directory app/helpers/admin has been updated"

    FileUtils.cp "#{helpers}/application_helper.rb", "#{AppRoot}/app/helpers"
    puts colored GREEN, "#{TAB2}File app/helpers/application_helper.rb has been updated"

    FileUtils.cp "#{helpers}/sessions_helper.rb", "#{AppRoot}/app/helpers"
    puts colored GREEN, "#{TAB2}File app/helpers/sessions_helper.rb has been added"

    ### Get generic files in the *policies* directory
    puts colored BLUE, "#{TAB}app/policies directory to be updated..."

    FileUtils.cp "#{policies}/panel_policy.rb", "#{AppRoot}/app/policies"
    puts colored GREEN, "#{TAB2}File app/policies/panel_policy.rb has been updated"

    FileUtils.cp "#{policies}/user_policy.rb", "#{AppRoot}/app/policies"
    puts colored GREEN, "#{TAB2}File app/policies/user_policy.rb has been updated"

    ### Get generic files in the *views* directory
    puts colored BLUE, "#{TAB}app/views directory to be updated..."

    FileUtils.cp_r "#{views}/layouts", "#{AppRoot}/app/views"
    puts colored GREEN, "#{TAB2}Directory app/views/layouts has been updated"

    # Update app/views/layouts/application.rb (App name)
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
    puts colored GREEN, "#{TAB2}File app/views/layouts/application.html.erb has been updated"

    # Directory *sessions*
    create_dir "app/views/sessions"
    FileUtils.cp_r "#{views}/sessions", "#{AppRoot}/app/views/"
    puts colored GREEN, "#{TAB2}Files have been copied to app/views/sessions"

    # Directory *pages*
    create_dir "app/views/pages"
    FileUtils.cp_r "#{views}/pages", "#{AppRoot}/app/views/"
    puts colored GREEN, "#{TAB2}Files have been copied to app/views/pages"

    # Directory *shared*
    create_dir "app/views/shared"
    FileUtils.cp_r "#{views}/shared", "#{AppRoot}/app/views/"
    puts colored GREEN, "#{TAB2}Files have been copied to app/views/shared"

    # Directory *admin*
    create_dir "app/views/admin/"
    FileUtils.cp_r "#{views}/admin", "#{AppRoot}/app/views/"
    puts colored GREEN, "#{TAB2}Files have been copied to app/views/admin"

    puts colored BLUE, "#{TAB}Cloning DONE"

  rescue Exception => error
    puts colored(RED, 'ACHTUNG! Something went wrong during cloning process...')
    puts colored(RED, error.message)
  end
end