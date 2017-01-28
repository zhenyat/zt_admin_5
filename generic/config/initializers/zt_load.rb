################################################################################
# zt_load.rb:
#   (1) Loads default config parameters from YAML file at Initialization Phase
#   (2) Updates parameters with values set for the Application Run
#
#   Source: http://railscasts.com/episodes/85-yaml-configuration-file
#
#   11.10.2016  ZT  Inherited from BKC 95km
################################################################################

# Gets default App configuration parameters
filename = 'config/zt_config/default_config.yml'
if File.exists? "#{Rails.root}/#{filename}"
  ZT_CONFIG = YAML.load_file("#{Rails.root}/#{filename}")[Rails.env]

  # Updates default configuration parameters for the current Application Run
  filename = 'config/zt_config/run_config.yml'
  if File.exists? "#{Rails.root}/#{filename}"
    run_config = YAML.load_file("#{Rails.root}/#{filename}")
    ZT_CONFIG.deep_merge! run_config if run_config.present?  # File contains values
  end
end

# Sets Constants and Parameters for the App run
filename = 'config/zt_config/settings.rb'
if File.exists? "#{Rails.root}/#{filename}"
  eval File.read("#{Rails.root}/#{filename}")
end
