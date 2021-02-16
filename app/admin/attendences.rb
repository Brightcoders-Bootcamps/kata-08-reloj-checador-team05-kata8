ActiveAdmin.register_page "Attendences" do
    menu parent: "Reports"

    controller do
        # definir metodo con joins para obtener las tablas de consulta checks and users
        def index
            attendences()
        end 

        def attendences 
            @date_from = params[:date_from] != nil ? params[:date_from] : Time.now.strftime("%Y-%m-%d").to_s
            @date_to = params[:date_to] != nil ? params[:date_to] : Time.now.strftime("%Y-%m-%d").to_s
            puts "today ---- #{@date_from}"
            @report = Check.where("created_at BETWEEN '#{@date_from}'::timestamp and '#{@date_to}'::timestamp")
            @avg_in = Check.select("AVG(CAST(created_at AS TIME)) as average").where("created_at BETWEEN '#{@date_from}'::timestamp and '#{@date_to}'::timestamp and type_check = 1")[0]
            @avg_out = Check.select("AVG(CAST(created_at AS TIME)) as average").where("created_at BETWEEN '#{@date_from}'::timestamp and '#{@date_to}'::timestamp and type_check = 2")[0]
            
            @avg_in = @avg_in[:average].is_a?(NilClass) ? '--' : format_hour(@avg_in[:average]) 
            @avg_out = @avg_out[:average].is_a?(NilClass) ? '--' : format_hour(@avg_out[:average])
        end

        def format_hour(str_hour)
            "#{str_hour.split(":")[0]}:#{str_hour.split(":")[1]}:#{str_hour.split(":")[2].split(".")[0]}"
        end
    end
    
    content only: :index do
        render partial: 'attendences'
    end
end