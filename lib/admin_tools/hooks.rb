module AdminTools
	module Hooks
	  class Hooks < Redmine::Hook::ViewListener

		# Add CSS class
		def view_layouts_base_html_head(context = { })
			stylesheet_link_tag 'admin_tools.css', :plugin => 'admin_tools'
		end

	  end
	end
end