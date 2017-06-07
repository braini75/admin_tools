class AdminToolsController < ApplicationController
  unloadable
  #before_filter :require_admin
  #require_sudo_mode :index
  helper :work_load


  def index
    
  end

  def show_config
    @settings = Setting.all
  end
  
  def import_holidays
    if (params[:year])
      @this_year=params[:year].to_i
    else 
      @this_year=Date.today.strftime("%Y").to_i
    end
    # Load Holiday List
    filter_year_start=Date.new(@this_year,01,01)
    filter_year_end=Date.new(@this_year,12,31)
    @wl_national_holiday = WlNationalHoliday.where("start between ? AND ?", filter_year_start, filter_year_end)
    @is_allowed = User.current.allowed_to_globally?(:edit_national_holiday)
    
    @url= (!Setting.plugin_admin_tools['holiday_import_url'].blank? ? Setting.plugin_admin_tools['holiday_import_url'] : false)
    
    @option="jahr=#{@this_year}&nur_land=TH"
    logger.info "Params: #{params.inspect}"
    load_json(params) if (params[:url] and params[:option])    
  end
    
  def save_import
    
      load_json(params)
        if @data
          holiday2import = Array.new
          @data.each do |holiday|
            if params[holiday[0]]
              holiday2import.push(holiday)
            end
          end
          
          if holiday2import.empty?
            flash.now[:warning] = "Nichts ausgewählt!"
          else
            # importieren!!!
            if params[:clear_year]
              ## lösche alle Einträge vom Jahr @this_year
              filter_year_start=Date.new(@this_year,01,01)
              filter_year_end=Date.new(@this_year,12,31)
              @wl_national_holiday = WlNationalHoliday.where("start between ? AND ?", filter_year_start, filter_year_end)
              @wl_national_holiday.each do |day|
                day.destroy
              end
            end
            
            holiday2import.each do |day|
              hd = WlNationalHoliday.new(:reason => day[0], :start => day[1]['datum'], :end => day[1]['datum'])
              hd.save
            end
          end
        end      
    #render "index"
    redirect_to(:controller => 'wl_national_holiday', :action => 'index', :notice => 'Holiday was successfully imported.', :year => params[:year])
  end
  
private
  def load_json(params)
    @url = params[:url] + "?" + params[:option]
      begin
        @data = JSON.load(open(@url))
      rescue Exception => e
        flash.now[:error] = e.message           
      end
  end  
end
