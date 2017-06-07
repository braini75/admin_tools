module AdminTools
	module Hooks
	  class Hooks < Redmine::Hook::ViewListener

		# Add CSS class
		def view_layouts_base_html_head(context = { })
			stylesheet_link_tag 'admin_tools.css', :plugin => 'admin_tools'
		end
		
		def view_wl_menu_extension(context = { })
		  ret_str =''
		  ret_str << '<p>'
		  ret_str << content_tag('span', link_to(l(:import_holidays),
                                            { :controller => 'admin_tools', :action => 'import_holidays', :year => @this_year },
                                            { :rel => 'nofollow', :title => l(:import_holidays) }))
		  ret_str << '</p>'
		  
		  if User.current.allowed_to_globally?(:edit_national_holiday)
        return ret_str.html_safe
      else
        return ''
      end
		end
	  end
	end
end