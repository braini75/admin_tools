Redmine::Plugin.register :admin_tools do
  name 'Admin Tools plugin'
  author 'Thomas Koch'
  description 'This is a plugin for Redmine providing some Admin Tools'
  version '1.2'
  url 'https://github.com/braini75/admin_tools'
  author_url 'https://github.com/braini75'
  
  menu :admin_menu, :admin_tools, { :controller => 'admin_tools', :action => 'index' }, :caption => 'Admin Tools'

  settings :partial => 'settings/admin_tools_settings',
           :default => {
             'holiday_import_url'   => "https://feiertage.jarmedia.de/api/",
             'proxy_url'            => "http://proxy.clondiag.jena:8080"
  }

end

require_dependency 'admin_tools/hooks'