# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do    
    match 'admin_tools/(:action)',via: [:get, :post], :controller => 'admin_tools'
end
