################################################################################
#
#   29.03.2018  Bug fixed for logout error (is it since Rails 5.2?):
#                 No route matches [GET] "/ru/logout" 
#               Solution: *get* instead of *delete*  - has been canceled (see below)
#               
#               Later: The bug is vanishing if to use *jquery_ujs* - MUSR BE!
################################################################################
Rails.application.routes.draw do

  if MULTILINGUAL

    scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do

      # Session resources
      get    'sessions/new'                                 # sessions_new_path
      post   'login',   to: 'sessions#create'               # login_path  - creates new session (login)
      delete 'logout',  to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)
     #get    'logout',  to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)

      namespace :admin do
        root 'panel#index'                                  # admin_root_path
        resources :users
        # 1: Add new admin resources before this line
      end

      root   'pages#home'                                   # root_path

    end

    # Root route is directed to default locale
    root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

    # All other routes without locales are directed to the same ones with locales
    get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

  else

    # Session resources
    get    'sessions/new'                                 # sessions_new_path
    post   'login',   to: 'sessions#create'               # login_path  - creates new session (login)
    delete 'logout',  to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)
   #get    'logout',  to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)
    
    namespace :admin do
      root 'panel#index'                                  # admin_root_path
      resources :users
      # 2: Add new admin resources before this line
    end

    root   'pages#home'                                   # root_path

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
