ActiveAdmin.register_page "Absences" do
    menu parent: "Reports"

    controller do
        # definir metodo con joins para obtener las tablas de consulta checks and users
        def index
            absences()
        end 

        def absences 
            @month = params[:month] != nil ? params[:month] : Time.now.strftime("%m").to_i
            @report = ActiveRecord::Base.connection.execute("SELECT * FROM absences(#{@month});")
            @tab = :abs
        end
    end

    content only: :index do
        render partial: 'absences'
    end
end
