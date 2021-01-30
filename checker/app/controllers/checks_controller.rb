class ChecksController < ApplicationController

    def show
        @check = Check.new
    end

    def create
        check_p = check_params
        private_number = check_params[:private_number]
        user = User.where('private_number = ?', [private_number])[0]
        return if user?(user) == false
        type_check = get_type_check(user[:id])
        if type_check != :checked
            checked_created = user.checks.create({type_check: type_check})
            msg = type_check == 1 ? "Check In! #{checked_created[:created_at].to_s}" : "Check Out! #{checked_created[:created_at].to_s}"
            redirect_to checks_path, notice: msg
        else
            redirect_to checks_path, notice: ("You have already checked")
        end
    end

    def user?(user)
        if user == nil
            redirect_to checks_path, notice: ("The private number doesn't exist") 
            return false
        end
        return true
    end

    def get_type_check(user_id)
        checks = Check.where("user_id = ? and to_char(created_at, 'dd-mm-YYYY') = ?", 1, Time.now.strftime("%d-%m-%Y"))
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
