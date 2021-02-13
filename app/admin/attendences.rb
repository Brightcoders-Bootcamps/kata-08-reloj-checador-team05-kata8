ActiveAdmin.register_page "Attendences" do
    menu parent: "Reports"

    controller do
        # definir metodo con joins para obtener las tablas de consulta checks and users
        def index
            attendences()
        end 

        def attendences 
            @month = params[:month] != nil ? params[:month] : Time.now.strftime("%m").to_i
            @report = Check.where("EXTRACT(MONTH from created_at) = #{@month}")
            @avg_in = Check.select("AVG(CAST(created_at AS TIME)) as average").where("EXTRACT(MONTH from created_at) = 2 and type_check = 1")[0]
            @avg_out = Check.select("AVG(CAST(created_at AS TIME)) as average").where("EXTRACT(MONTH from created_at) = 2 and type_check = 2")[0]
            @avg_in = format_hour(@avg_in[:average])
            @avg_out = format_hour(@avg_out[:average])
        end

        def format_hour(str_hour)
            "#{str_hour.split(":")[0]}:#{str_hour.split(":")[1]}:#{str_hour.split(":")[2].split(".")[0]}"
        end
    end
    
    content only: :index do
        render partial: 'attendences'
    end
end