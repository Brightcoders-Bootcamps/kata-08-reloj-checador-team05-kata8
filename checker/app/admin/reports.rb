ActiveAdmin.register_page "Reports" do
    controller do
        #definir metodo con joins para obtener las tablas de consulta checks and users
        def index
            @checks_per_day = User.joins(:checks).where(' type_check = 2') 
        end     
    end
    content only: :index do
        render partial: 'reports' 
    end
end