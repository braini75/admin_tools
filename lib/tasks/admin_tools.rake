namespace :admin_tools do
  desc "Importiere MIP Urlaubsdaten"
  task :import_mip_vaction => :environment do
    begin
      # Load all MIP UAs from start today and later
      @today=Date.today
            
      @uas = MipConnection.where("datum_von >= ? AND status IN (3,5)", @today)
      
      ua_size = @uas.size
      
      delete_all_local_vacations(@today)
                      
      @uas.each do |ua|
          create_new_entry(ua)
      end
    
    rescue ActiveRecord::StatementInvalid => error
       puts "MIP DB Error: #{error.inspect}"    
    
    rescue ActiveRecord::AdapterNotSpecified => error
      #puts "MIP DB Error: #{error}"
      puts " "
      puts "Cannot connect to DB. Make sure you setup config/database.yml!"
        puts " "
        puts "config/database.yml:
  mip_ua:
    adapter: mysql2
    database: hawaii_db
    host: cray.clondiag.jena
    username: hawaii_user
    password: ***
    encoding: utf8"
    
    rescue Mysql2::Error => e
      puts "DB Error: #{e.inspect}"
       
    end
  end
  
  def create_new_entry(ua)
    # create new record in WlUserVacation
    
    user=User.find_by login: ua.mitarbeiter
    
    if user
      @wl_user_vacation = WlUserVacation.new(
      :date_from      => ua.datum_von,
      :date_to        => ua.datum_bis,
      :vacation_type  => ua.urlaubsart,
      :ref_id         => ua.ua_id,
      :comments       => ua.bemerkung,
      :user_id        => user.id
      )
      if !@wl_user_vacation.save
        puts "Error saving record #{@wl_user_vacation.errors.full_messages.inspect}"
      end
    else
      # nothing to do      
    end
    
  end
  
  def delete_all_local_vacations(datum)
    # delete all user_vacations after "datum"
    user_vactions = WlUserVacation.where("date_from >= ? ", datum) rescue nil
    if user_vactions.nil?
      puts "Nothing to delete in local User Vacations!"
    else
      puts "Going to delete #{user_vactions.size} local User Vacations"
      user_vactions.each {|uv| uv.destroy}
    end
  end

end