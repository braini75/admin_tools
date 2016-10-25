Redmine::Plugin.register :admin_tools do
  name 'Admin Tools plugin'
  author 'Thomas Koch'
  description 'This is a plugin for Redmine poviding some Admin Tools'
  version '1.0'
  url 'https://github.com/braini75/admin_tools'
  author_url 'https://github.com/braini75'
  
  menu :admin_menu, :admin_tools, { :controller => 'admin_tools', :action => 'index' }, :caption => 'Admin Tools'
end
