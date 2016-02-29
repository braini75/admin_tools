class AdminToolsController < ApplicationController
  unloadable
  #before_filter :require_admin
  #require_sudo_mode :index


  def index
    
  end

  def show_config
    @settings = Setting.all
  end
end
