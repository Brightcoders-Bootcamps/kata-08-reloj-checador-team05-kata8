class ChecksController < ApplicationController

    def show
        @check = Check.new
    end

    def create
        begin
            check_p = check_params
            private_number = check_params[:private_number]
            user = User.where('private_number = ?', [private_number])[0]
            return if user?(user) == false
            type_check = get_type_check(user[:id])
            if type_check != :checked
                checked_created = user.checks.create({type_check: type_check})
                msg = type_check == 1 ? "Check In at #{checked_created[:created_at].to_s}" : "Check Out at #{checked_created[:created_at].to_s}"
                flash[:notice] = msg
                redirect_to :show
            else
                flash[:notice] = "You have already checked"
                redirect_to :show
            end
        rescue Exception => e
            flash[:alert] = "An error has ocurred. Try it later."
            redirect_to :show
        end
    end

    private 
    def user?(user)
        if user == nil
            @error = true
            flash[:alert] = "The private number doesn't exist"
            redirect_to checks_path 
            return false
        end
        return true
    end

    def get_type_check(user_id)
        checks = Check.where("user_id = ? and to_char(created_at, 'dd-mm-YYYY') = ?", user_id, Time.now.strftime("%d-%m-%Y"))
        if checks.empty?
            return 1 
        elsif checks.length == 1
            return 2
        else
            return :checked
        end
    end

    def check_params
        params.require(:check).permit(:private_number)        
    end
end
