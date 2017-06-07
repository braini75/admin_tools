class MipConnection < ActiveRecord::Base
    self.establish_connection(:mip_ua)
    self.table_name = 'ua' #Setting['plugin_admin_tools']['mip_host']
    
end